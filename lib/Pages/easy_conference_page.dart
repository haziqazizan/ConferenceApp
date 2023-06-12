import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:app_conference/Pages/homeConference.dart';
import 'package:app_conference/models/conference.dart';
import 'package:app_conference/models/specialization.dart';
import 'package:app_conference/Services/conference_database.dart';

class ConferenceFormPage extends StatefulWidget {
  const ConferenceFormPage({Key? key, this.specialization}) : super(key: key);
  final Conference? specialization;
  @override
  _ConferenceFormPageState createState() => _ConferenceFormPageState();
}

class _ConferenceFormPageState extends State<ConferenceFormPage> {
  final _formKey = GlobalKey<FormState>();
  String? dd;

  //declaration of services array into database
  List<String> area = [
    "Artificial Intelligence",
    "Data Mining",
    "Computer Security",
    "Internet of Things",
    "Software Engineering",
  ];

  //controller
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _roleController = TextEditingController();
  static final List<Specialization> _specialization = [];
  int c = 0;
  final DatabaseService _databaseService = DatabaseService();
  int _selectedSpecialization = 0;

  @override
  void initState() {
    super.initState();
    if (widget.specialization != null) {
      _nameController.text = widget.specialization!.name;
      _emailController.text = widget.specialization!.email;
      _phoneController.text = widget.specialization!.phone;
      _roleController.text = widget.specialization!.role;
      _selectedSpecialization = widget.specialization!.SpecializationId;
      dd = area[_selectedSpecialization - 1];
    }
  }

  Future<List<Specialization>> _getSpecialization() async {
    final specializationArea = await _databaseService.Special_types();
    if (_specialization.isEmpty) _specialization.addAll(specializationArea);
    if (widget.specialization != null) {
      _selectedSpecialization = _specialization
          .indexWhere((e) => e.id == widget.specialization!.SpecializationId);
    }
    return _specialization;
  }

  //insert register info into database function
  Future<void> _onSave() async {
    final name = _nameController.text;
    final email = _emailController.text;
    final phone = _phoneController.text;
    final role = _roleController.text;
    final specializationInsert = _specialization[_selectedSpecialization];
    final specializationUpdate = _specialization[c];
    widget.specialization == null
        ? await _databaseService.insertConferenceInfo(
            Conference(
                name: name,
                email: email,
                phone: phone,
                role: role,
                SpecializationId: specializationInsert.id!),
          )
        : await _databaseService.updateConferenceInfo(
            Conference(
              id: widget.specialization!.id,
              name: name,
              email: email,
              phone: phone,
              role: role,
              SpecializationId: specializationUpdate.id!,
            ),
          );

    CoolAlert.show(
      context: context,
      type: CoolAlertType.success,
      text: 'Booking information saved!',
      title: 'Success',
      onConfirmBtnTap: () {
        (Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const HomeConference(),
            fullscreenDialog: true,
          ),
        ));
      },
    );
  }

  //design of booking form page
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurple.shade700,
          title: const Text('Booking Form'),
          centerTitle: true,
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          color: const Color.fromRGBO(122, 196, 231, 1),
          padding: const EdgeInsets.all(12.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [
                          BoxShadow(
                              color: Colors.black26,
                              blurRadius: 6,
                              offset: Offset(0, 2))
                        ]),
                    height: 60,
                    child: TextFormField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                        hintText: 'Enter your full name',
                        fillColor: Colors.white,
                      ),
                      style: const TextStyle(fontSize: 15.0),

                      //validator for full name
                      validator: (value) {
                        if (value!.isEmpty ||
                            !RegExp(r'^[a-z A-Z]+$').hasMatch(value)) {
                          return 'Full name is required';
                        }
                        return null;
                      },
                    ),
                  ),

                  const SizedBox(height: 16.0),

                  Container(
                    margin: EdgeInsets.only(top: 10),
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black26,
                              blurRadius: 6,
                              offset: Offset(0, 2))
                        ]),
                    height: 60,
                    child: TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                        hintText: 'Enter your email',
                        fillColor: Colors.white,
                      ),
                      style: const TextStyle(fontSize: 15.0),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter your email';
                        }
                        // Check if the entered email has the right format
                        if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                          return 'Please enter a valid email address';
                        }
                        // Return null if the entered email is valid
                        return null;
                      },
                    ),
                  ),

                  const SizedBox(height: 16.0),

                  Container(
                    margin: EdgeInsets.only(top: 10),
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black26,
                              blurRadius: 6,
                              offset: Offset(0, 2))
                        ]),
                    height: 60,
                    child: TextFormField(
                      controller: _phoneController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                        hintText: 'Enter your phone number',
                        fillColor: Colors.white,
                      ),
                      style: const TextStyle(fontSize: 15.0),

                      //validator for phone number
                      validator: (value) {
                        if (value!.isEmpty ||
                            !RegExp(r'^[0-9]+$').hasMatch(value)) {
                          return 'Please enter correct phone number';
                        }
                        return null;
                      },
                    ),
                  ),

                  const SizedBox(height: 16.0),

                  Container(
                    margin: EdgeInsets.only(top: 10),
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black26,
                              blurRadius: 6,
                              offset: Offset(0, 2))
                        ]),
                    height: 60,
                    child: TextFormField(
                      controller: _roleController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                        hintText: 'Enter your role',
                        fillColor: Colors.white,
                      ),
                      style: const TextStyle(fontSize: 15.0),

                      //validator for date
                      validator: (value) {
                        if (value!.isEmpty ||
                            !RegExp(r'^[a-z A-Z]+$').hasMatch(value)) {
                          return 'role is required';
                        }
                        return null;
                      },
                    ),
                  ),

                  const SizedBox(height: 16.0),

                  //dropdown menu for services
                  FutureBuilder<List<Specialization>>(
                    future: _getSpecialization(),
                    builder: (context, snapshot) => (DropdownButtonFormField(
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                        ),

                        //validator for services
                        validator: (value) =>
                            value == null ? "Area needed is required" : null,
                        dropdownColor: Color.fromARGB(255, 255, 255, 255),
                        value: dd,
                        hint: const Text(
                          "Select Area",
                          style:
                              TextStyle(color: Color.fromRGBO(38, 62, 109, 1)),
                          textAlign: TextAlign.end,
                        ),
                        style: const TextStyle(fontSize: 15.0),
                        onChanged: (String? newValue) {
                          setState(() {
                            dd = newValue!;
                            for (int i = 0; i < area.length; i++) {
                              if (newValue == area[i]) {
                                _selectedSpecialization = i;
                                c = i;
                              }
                            }
                          });
                        },
                        items: area.map((String items) {
                          return DropdownMenuItem(
                            value: items,
                            child: Text(
                              items,
                              style: const TextStyle(
                                  color: Color.fromRGBO(38, 62, 109, 1)),
                            ),
                          );
                        }).toList())),
                  ),

                  const SizedBox(height: 24.0),

                  //button to save booking appointment
                  SizedBox(
                    height: 45.0,
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              const Color.fromRGBO(38, 62, 109, 1)),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ))),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _onSave();
                        }
                      },
                      child: const Text(
                        'Add Register Details',
                        style: TextStyle(
                          fontSize: 15.0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
