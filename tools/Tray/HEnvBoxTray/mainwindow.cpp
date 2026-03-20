#include "mainwindow.h"
#include <QMessageBox>
#include <QFileInfo>
#include "./ui_mainwindow.h"

MainWindow::MainWindow(QWidget *parent)
    : QMainWindow(parent)
    , ui(new Ui::MainWindow)
    ,app_instance_pid("/tmp/" HENVBOX_ROOT_PATH "app_instance_pid_henvboxtray",nullptr),
      m_trayicon(this)
{
    ui->setupUi(this);
    hide();
    app_instance_pid_check();
    //打开创建系统图标
    m_trayicon.setIcon(QIcon(QString::fromUtf8(":/HEnvBox-256x256.ico")));
    m_trayicon.show();
    m_trayicon.setContextMenu(new QMenu(this));
    {
        //创建菜单
        QMenu *menu=m_trayicon.contextMenu();
        if(menu!=NULL)
        {
            {
                //添加路径显示(通过菜单打开相应目录)
                QAction * act=menu->addAction(QIcon(QString::fromUtf8(":/HEnvBox-256x256.ico")),HENVBOX_ROOT_PATH);
                connect(act,&QAction::triggered,[=](bool check)
                {
                    if(QFile::exists(HENVBOX_ROOT_PATH))
                    {
                        QDesktopServices::openUrl(QUrl::fromLocalFile(HENVBOX_ROOT_PATH));
                    }
                });
                menu->addSeparator();
            }
            {
                QMenu *submenu=menu->addMenu(QIcon(QString::fromUtf8(":/HEnvBox-256x256.ico")),tr("Maintanence"));
                //添加脚本的快捷启动方式
                QDir root(HENVBOX_ROOT_PATH);
                if(root.isReadable())
                {
                    QStringList filters;
#ifdef  WIN32
                    filters << "*.bat";
#else
                    filters << "*.sh";
#endif
                    foreach (const QString &scriptname, root.entryList(filters))
                    {
                        if(scriptname=="config.bat" || scriptname == "config.sh")
                        {
                            //跳过config.bat或config.sh
                            continue;
                        }
                        qDebug() << "Found script:" << scriptname;
                        {
                            QString scriptpath=QString(HENVBOX_ROOT_PATH)+"/"+scriptname;
                            QAction * act=submenu->addAction(QIcon(QString::fromUtf8(":/HEnvBox-256x256.ico")),scriptname);
                            connect(act,&QAction::triggered,[=](bool check)
                            {
                                if(!StartScript(scriptpath))
                                {
                                    QMessageBox::warning(this,tr("Warning"),tr("start script failed!"));
                                }
                            });
                        }
                    }
                    submenu->addSeparator();
                }
                menu->addSeparator();
            }
#if !defined(WIN32)
            {
                //添加bash
                QAction * act=menu->addAction(QIcon(QString::fromUtf8(":/Terminal.png")),tr("Bash"));
                connect(act,&QAction::triggered,[=](bool check)
                        {

                            if(!StartScript(QString::fromLocal8Bit("bash")))
                            {
                                QMessageBox::warning(this,tr("Warning"),tr("start script failed!"));
                            }
                        });
                menu->addSeparator();
            }
#else
            {
                //添加终端工具
                QMenu *submenu=menu->addMenu(QIcon(QString::fromUtf8(":/Terminal.png")),tr("Tools"));
                if(QFileInfo(QString::fromLocal8Bit(HENVBOX_TOOLS_PATH)+QString::fromLocal8Bit("/ConEmu/ConEmu.exe")).exists())
                {
                    QAction * act=submenu->addAction(QIcon(QString::fromUtf8(":/Terminal.png")),tr("Cmd"));
                    connect(act,&QAction::triggered,[=](bool check)
                            {
                                QStringList scriptargs;
                                {
                                    scriptargs << "-Here";
                                    scriptargs << "-run";
                                    scriptargs << "cmd.exe /k " HENVBOX_ROOT_PATH  "/config.bat";
                                }
                                if(!StartScript(QString::fromLocal8Bit(HENVBOX_TOOLS_PATH)+QString::fromLocal8Bit("/ConEmu/ConEmu.exe"),scriptargs))
                                {
                                    QMessageBox::warning(this,tr("Warning"),tr("start script failed!"));
                                }
                            });
                    submenu->addSeparator();
                }
                {
                    QString MSYS2_ROOT_PATH=QString::fromLocal8Bit(HENVBOX_LOCAL_ROOT_PATH "/" HENVBOX_TOOLS_TYPE);
                    const char *MSYS2_ENV_LIST[]=
                    {
                        "mingw32",
                        "mingw64",
                        "clang64",
                        "ucrt64",
                        "msys2"
                    };
                    for(size_t i=0;i<sizeof(MSYS2_ENV_LIST)/sizeof(MSYS2_ENV_LIST[0]);i++)
                    {
                        QString MSYS2_ENV_PATH=MSYS2_ROOT_PATH+QString::fromLocal8Bit("/")+QString::fromLocal8Bit(MSYS2_ENV_LIST[i])+QString::fromLocal8Bit(".exe");
                        if(QFileInfo(MSYS2_ENV_PATH).exists())
                        {
                            QAction * act=submenu->addAction(QIcon(QString::fromUtf8(":/Terminal.png")),QString::fromLocal8Bit(MSYS2_ENV_LIST[i]));
                            connect(act,&QAction::triggered,[=](bool check)
                                    {
                                        QStringList scriptargs;
                                        {
                                            scriptargs << "/console";
                                        }
                                        if(!StartScript(MSYS2_ENV_PATH,scriptargs))
                                        {
                                            QMessageBox::warning(this,tr("Warning"),tr("start script failed!"));
                                        }
                                    });
                            submenu->addSeparator();
                        }
                    }
                }
                menu->addSeparator();
            }
#endif
            {
                //添加退出操作
                QAction * act=menu->addAction(QIcon(QString::fromUtf8(":/Exit.png")),tr("Exit"));
                connect(act,&QAction::triggered,[=](bool check)
                {
                    //退出托盘程序
                    QCoreApplication::exit();
                });
                menu->addSeparator();
            }
        }
    }
    connect(&m_trayicon,&QSystemTrayIcon::activated,this,&MainWindow::Trayiconactivated);

}

MainWindow::~MainWindow()
{
    delete ui;
}

bool MainWindow::StartScript(QString scriptpath,QStringList scriptenargs)
{
#ifdef WIN32
    return QProcess::startDetached(scriptpath,scriptenargs);
#else

    {
        QStringList args;
        QString term="deepin-terminal";
        args << "--version";
        if(QProcess::execute(term,args)==0)
        {
            args.clear();
            args << "-e";
            args << scriptpath;
            args << scriptenargs;
            return QProcess::startDetached(term,args);
        }
    }

    {
        QStringList args;
        QString term="gnome-terminal";
        args << "--version";
        if(QProcess::execute(term,args)==0)
        {
            args.clear();
            args << "--";
            args << scriptpath;
            args << scriptenargs;
            return QProcess::startDetached(term,args);
        }
    }

    {
        QStringList args;
        QString term="konsole";
        args << "--version";
        if(QProcess::execute(term,args)==0)
        {
            args.clear();
            args << "-e";
            args << scriptpath;
            args << scriptenargs;
            return QProcess::startDetached(term,args);
        }
    }


    {
        QStringList args;
        QString term="xfce4-terminal";
        args << "--version";
        if(QProcess::execute(term,args)==0)
        {
            args.clear();
            args << "-e";
            args << scriptpath;
            args << scriptenargs;
            return QProcess::startDetached(term,args);
        }
    }

    {
        QStringList args;
        QString term="qterminal";
        args << "--version";
        if(QProcess::execute(term,args)==0)
        {
            args.clear();
            args << "-e";
            args << scriptpath;
            args << scriptenargs;
            return QProcess::startDetached(term,args);
        }
    }

    {
        QStringList args;
        QString term="lxterminal";
        args << "--version";
        if(QProcess::execute(term,args)==0)
        {
            args.clear();
            args << "-e";
            args << scriptpath;
            args << scriptenargs;
            return QProcess::startDetached(term,args);
        }
    }

    {
        QStringList args;
        QString term="x-terminal-emulator";
        args << "-version";
        if(QProcess::execute(term,args)==0)
        {
            args.clear();
            args << "-e";
            args << scriptpath;
            args << scriptenargs;
            return QProcess::startDetached(term,args);
        }
    }
    {
        QStringList args;
        QString term="x-terminal-emulator";
        args << "--version";
        if(QProcess::execute(term,args)==0)
        {
            args.clear();
            args << "-e";
            args << scriptpath;
            args << scriptenargs;
            return QProcess::startDetached(term,args);
        }
    }

    {
        QStringList args;
        QString term="xterm";
        args << "-version";
        if(QProcess::execute(term,args)==0)
        {
            args.clear();
            args << "-e";
            args << scriptpath;
            args << scriptenargs;
            return QProcess::startDetached(term,args);
        }
    }
#endif
    return false;
}

void MainWindow::app_instance_pid_check()
{
    int pid=QCoreApplication::applicationPid();
    qDebug() << "current process pid is "<<pid<<"!";
    if(app_instance_pid.attach())
    {
        int pid_old=*(const int *)app_instance_pid.constData();
        if(pid!=pid_old)
        {
            //TODO:检查现有的进程

#ifdef __linux__
            if(!QFile::exists(QString("/proc/")+std::to_string(pid_old).c_str()))
            {
                (*(int *)app_instance_pid.data())=pid;
                return;
            }
#endif
            qDebug() << "process(pid="<<pid_old<<") is running!";
            //只允许一个实例
            qDebug() << "Exiting" ;
            exit(-1);
        }
    }
    if(app_instance_pid.create(sizeof(int)))
    {
        (*(int *)app_instance_pid.data())=pid;
    }
}

void MainWindow::Trayiconactivated(QSystemTrayIcon::ActivationReason reason)
{
    switch (reason)
    {
    case QSystemTrayIcon::Context:
    {
        //上下文菜单，一般指右键菜单
    }
    break;
    case QSystemTrayIcon::DoubleClick:
    {
        //双击
    }
    break;
    case QSystemTrayIcon::Trigger:
    {
        //点击
    }
    break;
    default:
    {

    }
    break;
    }
}
