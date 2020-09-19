import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:typed_data/typed_data.dart' as typed;
import 'package:imagebutton/imagebutton.dart';
Future<int> publishon() async {
  // Create and connect the client
  const url = 'broker.mqtt-dashboard.com';
  const port = 1883; // You can also use 8883 if you so wish
  // The client id is a path to your device, example given below, note this contravenes the 23 character client id length
  // from the MQTT specification, the mqtt_client allows this, if exceeded and logging is turned on  a warning is given.

  const username = '';
  // Password contains the encoded JWT token, example below, the JWT token when generated should be encoded with the private key coresponding
  // to the public key you have set for your device.
  const password ='';
  // Create the client
  const clientId = 'abhijith001';
  // User name is not used and can be set to anything, it is needed because the password field contains the encoded JWT token for the device
  final client = MqttServerClient(url, clientId);
  // Set the port
  client.port = port;
  // Set secure
  client.secure = false;
  // Set the security context as you need, note this is the standard Dart SecurityContext class.
  // If this is incorrect the TLS handshake will abort and a Handshake exception will be raised,
  // no connect ack message will be received and the broker will disconnect.
  //final currDir = '${path.current}${path.separator}example${path.separator}';
  //final context = SecurityContext.defaultContext;
  // context.setTrustedCertificates(currDir + path.join('pem', 'roots.pem'));
  // If needed set the private key file path and the optional passphrase and any other supported security features
  // Note that for flutter users the parameters above can be set in byte format rather than file paths.
  //client.securityContext = context;
  // Set the protocol to V3.1.1 for iot-core, if you fail to do this you will receive a connect ack with the response code
  // 0x01 Connection Refused, unacceptable protocol version
  client.setProtocolV311();
  // logging if you wish
  client.logging(on: true);
  // OK, connect, if your encoded JWT token in the password field cannot be decoded by the corresponding public key attached
  // to the device or the JWT token is incorrect a connect ack message will be received with a return code of
  // 0x05 Connection Refused, not authorized. If the password field is not set at all the return code may be
  // 0x04 Connection Refused, bad user name or password
  await client.connect(username, password);
  if (client.connectionStatus.state == MqttConnectionState.connected) {
    print('iotcore client connected');
  } else {
    print(
        'ERROR iotcore client connection failed - disconnecting, state is ${client.connectionStatus.state}');
    client.disconnect();
  }
  // Troubleshooting tips can be found here https://cloud.google.com/iot/docs/troubleshooting
  // Publish to the topic you have associated with your device
  const topic = 'inTopic';
  // Use a raw buffer here, see MqttClientPayloadBuilder for payload building assistance.
  final buff = typed.Uint8Buffer(4);
  buff[0] = 'a'.codeUnitAt(0);
  client.publishMessage(topic, MqttQos.exactlyOnce, buff);
  print('Sleeping....');
  await MqttUtilities.asyncSleep(10);
  print('Disconnecting');
  client.disconnect();
  return 0;
}

Future<int> publishoff() async {
  // Create and connect the client
  const url = 'broker.mqtt-dashboard.com';
  const port = 1883; // You can also use 8883 if you so wish
  // The client id is a path to your device, example given below, note this contravenes the 23 character client id length
  // from the MQTT specification, the mqtt_client allows this, if exceeded and logging is turned on  a warning is given.

  const username ='';
  // Password contains the encoded JWT token, example below, the JWT token when generated should be encoded with the private key coresponding
  // to the public key you have set for your device.
  const password ='';
  // Create the client
  const clientId = 'abhijith001';
  // User name is not used and can be set to anything, it is needed because the password field contains the encoded JWT token for the device
  final client = MqttServerClient(url, clientId);
  // Set the port
  client.port = port;
  // Set secure
  client.secure = false;
  // Set the security context as you need, note this is the standard Dart SecurityContext class.
  // If this is incorrect the TLS handshake will abort and a Handshake exception will be raised,
  // no connect ack message will be received and the broker will disconnect.
  //final currDir = '${path.current}${path.separator}example${path.separator}';
  //final context = SecurityContext.defaultContext;
  // context.setTrustedCertificates(currDir + path.join('pem', 'roots.pem'));
  // If needed set the private key file path and the optional passphrase and any other supported security features
  // Note that for flutter users the parameters above can be set in byte format rather than file paths.
  //client.securityContext = context;
  // Set the protocol to V3.1.1 for iot-core, if you fail to do this you will receive a connect ack with the response code
  // 0x01 Connection Refused, unacceptable protocol version
  client.setProtocolV311();
  // logging if you wish
  client.logging(on: true);
  // OK, connect, if your encoded JWT token in the password field cannot be decoded by the corresponding public key attached
  // to the device or the JWT token is incorrect a connect ack message will be received with a return code of
  // 0x05 Connection Refused, not authorized. If the password field is not set at all the return code may be
  // 0x04 Connection Refused, bad user name or password
  await client.connect(username, password);
  if (client.connectionStatus.state == MqttConnectionState.connected) {
    print('iotcore client connected');
  } else {
    print(
        'ERROR iotcore client connection failed - disconnecting, state is ${client.connectionStatus.state}');
    client.disconnect();
  }
  // Troubleshooting tips can be found here https://cloud.google.com/iot/docs/troubleshooting
  // Publish to the topic you have associated with your device
  const topic = 'inTopic';
  // Use a raw buffer here, see MqttClientPayloadBuilder for payload building assistance.
  final buff = typed.Uint8Buffer(4);
  buff[0] = 'b'.codeUnitAt(0);
  client.publishMessage(topic, MqttQos.exactlyOnce, buff);
  print('Sleeping....');
  await MqttUtilities.asyncSleep(10);
  print('Disconnecting');
  client.disconnect();
  return 0;
}


class Home extends StatefulWidget {
  @override..
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map data={};

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: const Text("Smart Iot Light"),
      ),
      body: Center(

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("SMART IoT LIGHT",style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
            SizedBox(
              height: 5,
            ),
            Text("Developed by: Abhijith S S", style:TextStyle(fontSize: 15,fontWeight: FontWeight.bold)),
            SizedBox(
              height: 20,
            ),
            ImageButton(
              children: <Widget>[],
              width: 100,
              height: 100,
              paddingTop: 5,
              pressedImage: Image.asset(
                  "assets/yellow_button.png"),
              unpressedImage: Image.asset("assets/on_button.png"),
              onTap: () {
                publishon();
              },
            ),
            SizedBox(height: 20),
            ImageButton(
              children: <Widget>[],
              width: 100,
              height: 100,
              paddingTop: 5,
              pressedImage: Image.asset(
                  "assets/yellow_button.png"),
              unpressedImage: Image.asset("assets/off_button.png"),
              onTap: () {
                publishoff();
              },
            ),
          ],
        ),
      ),
    );
  }
}
