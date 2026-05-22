#ifndef MPVRENDERER_H_
#define MPVRENDERER_H_

#include <QtQuick/QQuickFramebufferObject>

#include <mpv/client.h>
#include <mpv/render_gl.h>
#include "qthelper.hpp"

class MpvRenderer;

class MpvObject : public QQuickFramebufferObject
{
    Q_OBJECT

    mpv_handle *mpv;
    mpv_render_context *mpv_gl;

    friend class MpvRenderer;

public:
    static void on_update(void *ctx);

    MpvObject(QQuickItem * parent = 0);
    virtual ~MpvObject();
    virtual Renderer *createRenderer() const;

    Q_PROPERTY(double position READ position NOTIFY onUpdate FINAL)
    Q_PROPERTY(double timeRemaining READ timeRemaining NOTIFY onUpdate FINAL)
    Q_PROPERTY(int estFrameNumber READ estFrameNumber NOTIFY onUpdate FINAL)
    Q_PROPERTY(int estVfFps READ estVfFps NOTIFY onUpdate FINAL)
    Q_PROPERTY(bool paused READ paused NOTIFY onUpdate FINAL)
    Q_PROPERTY(double percentPos READ percentPos NOTIFY onUpdate FINAL)
    // currently updating frames on onUpdate - there might be a more efficient way of doing this - Claire Rosenthal

    double position();
    double timeRemaining();
    int estFrameNumber();
    int estVfFps();
    bool paused();
    double percentPos();


public slots:
    void command(const QVariant& params);
    void setProperty(const QString& name, const QVariant& value);
    QVariant getProperty(const QString& name);
    QString secondsToTimecode(double seconds);
    // ^ this is technically a static function, but I'm unaware how to reference a static function from QML - Claire Rosenthal

signals:
    void onUpdate();

private slots:
    void doUpdate();
};

#endif
