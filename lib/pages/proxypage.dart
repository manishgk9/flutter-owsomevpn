import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:owsomevpn/controllers/home_controller.dart';
// Correct path to your controller

class ProxySettingsPage extends StatelessWidget {
  final ProxyController _proxyController = Get.put(ProxyController());

  ProxySettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0E21),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        // centerTitle: true,
        title: const Text(
          'Proxy Settings',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color.fromARGB(
            255, 33, 18, 62), // User's preferred blue shade
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Only use Obx for widgets that are dependent on observable variables

              // Proxy Address Input (Not wrapped in Obx as no reactive value is involved)
              TextField(
                style: const TextStyle(color: Colors.grey),
                onChanged: (value) {
                  _proxyController.proxyAddress.value =
                      value; // Updating the reactive variable directly
                },
                decoration: const InputDecoration(
                  labelText: 'Proxy Address',
                  labelStyle: TextStyle(color: Colors.grey),
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.url,
              ),
              const SizedBox(height: 16),

              // Port Input (Not wrapped in Obx as no reactive value is involved)
              TextField(
                style: const TextStyle(color: Colors.grey),
                onChanged: (value) {
                  _proxyController.port.value =
                      value; // Updating the reactive variable directly
                },
                decoration: const InputDecoration(
                  labelText: 'Port',
                  labelStyle: TextStyle(color: Colors.grey),
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),

              // Use Authentication Toggle (Wrapped in Obx)
              Obx(() => SwitchListTile(
                    activeColor: Colors.green,
                    title: const Text(
                      'Use Authentication',
                      style: TextStyle(color: Colors.grey),
                    ),
                    value: _proxyController.useAuth.value,
                    onChanged: (value) {
                      _proxyController.toggleAuth(value);
                    },
                  )),

              // Username and Password if Authentication is On (Wrapped in Obx)
              Obx(() => _proxyController.useAuth.value
                  ? Column(
                      children: [
                        TextField(
                          style: const TextStyle(color: Colors.grey),
                          onChanged: (value) {
                            _proxyController.username.value =
                                value; // Updating the reactive variable
                          },
                          decoration: const InputDecoration(
                            labelText: 'Username',
                            labelStyle: TextStyle(color: Colors.grey),
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 16),
                        TextField(
                          style: const TextStyle(color: Colors.grey),
                          onChanged: (value) {
                            _proxyController.password.value =
                                value; // Updating the reactive variable
                          },
                          decoration: const InputDecoration(
                            labelText: 'Password',
                            labelStyle: TextStyle(color: Colors.grey),
                            border: OutlineInputBorder(),
                          ),
                          obscureText: true,
                        ),
                      ],
                    )
                  : const SizedBox.shrink()),
              const SizedBox(height: 32),

              // Save Button (No need for Obx here, as it doesn't depend on any reactive variable)
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // Handle saving of proxy settings
                    print(
                        'Proxy Address: ${_proxyController.proxyAddress.value}');
                    print('Port: ${_proxyController.port.value}');
                    print(
                        'Username: ${_proxyController.useAuth.value ? _proxyController.username.value : 'N/A'}');
                    print(
                        'Password: ${_proxyController.useAuth.value ? _proxyController.password.value : 'N/A'}');
                    Get.defaultDialog(
                        confirm: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color.fromARGB(255, 23, 54, 105)),
                            onPressed: () {
                              Get.back();
                            },
                            child: Text(
                              "Ok",
                              style: TextStyle(
                                  color: Colors.grey[100],
                                  fontWeight: FontWeight.bold),
                            )),
                        backgroundColor: const Color.fromARGB(255, 22, 51, 86),
                        title: 'Attention !',
                        titleStyle: TextStyle(color: Colors.redAccent),
                        content: Text(
                          "This is ui only in future works",
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(
                        255, 34, 47, 87), // User's preferred blue shade
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 15),
                  ),
                  child: Text('Save Settings',
                      style: TextStyle(color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
