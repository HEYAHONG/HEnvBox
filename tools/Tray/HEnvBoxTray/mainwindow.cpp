#include "mainwindow.h"
#include "./ui_mainwindow.h"

MainWindow::MainWindow(QWidget *parent)
    : QMainWindow(parent)
    , ui(new Ui::MainWindow)
    ,app_instance_pid("app_instance_pid_henvboxtray",nullptr),
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
                //添加退出操作
                QAction * act=menu->addAction("Exit");
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

void MainWindow::app_instance_pid_check()
{
    int pid=QCoreApplication::applicationPid();
    qDebug() << "current process pid is "<<pid<<"!";
    app_instance_pid.setNativeKey("app_instance_pid_henvboxtray");
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
