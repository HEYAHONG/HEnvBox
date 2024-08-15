#ifndef MAINWINDOW_H
#define MAINWINDOW_H

#include <QMainWindow>
#include <QSharedMemory>
#include <QProcess>
#include <QSystemTrayIcon>
#include <QIcon>
#include <QFile>
#include <QMenu>
#include <QDebug>

QT_BEGIN_NAMESPACE
namespace Ui {
class MainWindow;
}
QT_END_NAMESPACE

class MainWindow : public QMainWindow
{
    Q_OBJECT

public:
    MainWindow(QWidget *parent = nullptr);
    ~MainWindow();

private:
    Ui::MainWindow *ui;
    QSharedMemory  app_instance_pid;
    void app_instance_pid_check();
    QSystemTrayIcon m_trayicon;
public slots:
    void 	Trayiconactivated(QSystemTrayIcon::ActivationReason reason);
};
#endif // MAINWINDOW_H
