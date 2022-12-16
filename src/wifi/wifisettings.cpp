#include "plugin.h"

WifiSettings::WifiSettings(QObject *parent) : QObject(parent) {
    QDBusInterface networkManager(
	    "org.freedesktop.NetworkManager",
        "/org/freedesktop/NetworkManager", 
	    "org.freedesktop.NetworkManager",
        QDBusConnection::systemBus()
    );

    QDBusReply<QList<QDBusObjectPath>> devicesReply = networkManager.call("GetDevices");
    if (!devicesReply.isValid()) return;
    QList<QDBusObjectPath> devices = devicesReply.value();

    m_wlanPath = QDBusObjectPath("/");
    foreach (QDBusObjectPath path, devices) {
        QDBusInterface deviceInterface(
            "org.freedesktop.NetworkManager",
            path.path(), 
            "org.freedesktop.DBus.Properties",
            QDBusConnection::systemBus()
        );
        QDBusReply<QDBusVariant> typeReply = deviceInterface.call(
            "Get", "org.freedesktop.NetworkManager.Device", "DeviceType"
        );
        if (typeReply.isValid()) {
            uint type = qdbus_cast<uint>(typeReply.value().variant());
            if (type == 2) { // Wireless LAN
                m_wlanPath = path;
                break;
            }
        }
    }

    if (m_wlanPath.path() == "") return;
    
    QDBusInterface deviceInterface(
        "org.freedesktop.NetworkManager",
        m_wlanPath.path(), 
        "org.freedesktop.DBus.Properties",
        QDBusConnection::systemBus()
    );
    QDBusReply<QDBusVariant> apReply = deviceInterface.call(
        "Get", "org.freedesktop.NetworkManager.Device.Wireless", "AccessPoints"
    );

    if (!apReply.isValid()) return;
    foreach (QDBusObjectPath path, qdbus_cast<QList<QDBusObjectPath>>(apReply.value().variant())) {
        if (path.path() == "/") continue;
        WifiAccessPoint* wifiAP = new WifiAccessPoint(this);
        wifiAP->setPath(path.path());
        m_accessPoints.insert(path, wifiAP);
        emit accessPointsChanged(accessPoints());
    }

    apReply = deviceInterface.call(
        "Get", "org.freedesktop.NetworkManager.Device.Wireless", "ActiveAccessPoint"
    );
    if (apReply.isValid()) {
        m_activeAccessPoint = qdbus_cast<QDBusObjectPath>(apReply.value().variant());
        emit activeAccessPointChanged(m_accessPoints.value(m_activeAccessPoint));
    }

    QDBusConnection::systemBus().connect(
        "org.freedesktop.NetworkManager",
        m_wlanPath.path(), 
        "org.freedesktop.NetworkManager.Device.Wireless", 
        "AccessPointAdded",
        this, SLOT(onAccessPointAdded(QDBusObjectPath)));

    QDBusConnection::systemBus().connect(
        "org.freedesktop.NetworkManager",
        m_wlanPath.path(), 
        "org.freedesktop.NetworkManager.Device.Wireless", 
        "AccessPointRemoved",
        this, SLOT(onAccessPointRemoved(QDBusObjectPath)));

    QDBusConnection::systemBus().connect(
        "org.freedesktop.NetworkManager",
        m_wlanPath.path(), 
        "org.freedesktop.DBus.Properties", 
        "PropertiesChanged",
        this, SLOT(onPropertiesChanged(QString,QMap<QString, QVariant>,QStringList)));
}

WifiSettings::~WifiSettings() {}

QList<WifiAccessPoint *> WifiSettings::accessPoints() {
    QList<WifiAccessPoint *> aps = m_accessPoints.values();
    std::sort(aps.begin(), aps.end(), 
      [](WifiAccessPoint* const a, WifiAccessPoint* const b) -> bool { 
        return (qdbus_cast<uint>(a->data().value("Strength")) > qdbus_cast<uint>(b->data().value("Strength"))); });
    return aps;
}

WifiAccessPoint *WifiSettings::activeAccessPoint() {
    return m_accessPoints.value(m_activeAccessPoint);
}

void WifiSettings::onAccessPointAdded(QDBusObjectPath path) {
    WifiAccessPoint* wifiAP = new WifiAccessPoint(this);
        wifiAP->setPath(path.path());
    m_accessPoints.insert(path, wifiAP);
    emit accessPointsChanged(accessPoints());
}

void WifiSettings::onAccessPointRemoved(QDBusObjectPath path) {
    m_accessPoints.remove(path);
    emit accessPointsChanged(accessPoints());
}

QObject *WifiSettings::provider(QQmlEngine *engine, QJSEngine *scriptEngine) {
    Q_UNUSED(scriptEngine);
    return new WifiSettings(engine);
}

void WifiSettings::onPropertiesChanged(QString iface, QMap<QString, QVariant> updated, QStringList invalidated) {
    Q_UNUSED(invalidated);
    if (iface == "org.freedesktop.NetworkManager.Device.Wireless") {
        if (updated.contains("ActiveAccessPoint")) {
            m_activeAccessPoint = qdbus_cast<QDBusObjectPath>(updated.value("ActiveAccessPoint"));
            emit activeAccessPointChanged(m_accessPoints.value(m_activeAccessPoint));
        }
    };
}

void WifiSettings::requestScan() {
    QDBusInterface(
        "org.freedesktop.NetworkManager",
        m_wlanPath.path(), 
        "org.freedesktop.NetworkManager.Device.Wireless",
        QDBusConnection::systemBus()
    ).call("RequestScan", QMap<QString,QVariant>());
}