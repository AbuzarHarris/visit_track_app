import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:personal_phone_dictionary/components/chips_input.dart';
import 'package:personal_phone_dictionary/components/form_input_component.dart';
import 'package:personal_phone_dictionary/components/single_dropdown_component.dart';
import 'package:personal_phone_dictionary/utils/constants.dart';

class AddNewContact extends StatefulWidget {
  const AddNewContact({super.key});

  @override
  State<AddNewContact> createState() => _AddNewContactState();
}

class _AddNewContactState extends State<AddNewContact> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _internalReferenceController =
      TextEditingController();
  final TextEditingController _externalReferenceController =
      TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _phoneNumberController2 = TextEditingController();
  final TextEditingController _whatsappNumberController =
      TextEditingController();
  final TextEditingController _segmentIDController = TextEditingController();
  final TextEditingController _tehsilIDController = TextEditingController();
  final TextEditingController _drawerTextController = TextEditingController();
  bool showPassword = false;
  bool? sameAsMobileNo = false;

  List<String> list = <String>[
    'One',
    'Two',
    'Three',
    'Four',
    'Four',
    'Four',
    'Four',
    'Four',
    'Four',
    'Four',
    'Four',
    'Four',
    'Four'
  ];
  List<String> tagsData = <String>[
    'Business',
    'Doctor',
    'Software',
    'Food Chain'
  ];
  final FocusNode _chipFocusNode = FocusNode();
  List<String> selectedTags = <String>[];
  List<String> _suggestions = <String>[];
  Future<void> _onSearchChanged(String value) async {
    final List<String> results = await _suggestionCallback(value);
    setState(() {
      _suggestions = results
          .where((String topping) => !selectedTags.contains(topping))
          .toList();
    });
  }

  Widget _chipBuilder(BuildContext context, String topping) {
    return ToppingInputChip(
      topping: topping,
      onDeleted: _onChipDeleted,
      onSelected: _onChipTapped,
    );
  }

  void _selectSuggestion(String topping) {
    setState(() {
      selectedTags.add(topping);
      _suggestions = <String>[];
    });
  }

  void _onChipTapped(String topping) {}
  void _onChipDeleted(String topping) {
    setState(() {
      selectedTags.remove(topping);
      _suggestions = <String>[];
    });
  }

  void _onSubmitted(String text) {
    if (text.trim().isNotEmpty) {
      setState(() {
        selectedTags = <String>[...selectedTags, text.trim()];
      });
    } else {
      _chipFocusNode.unfocus();
      setState(() {
        selectedTags = <String>[];
      });
    }
  }

  void _onChanged(List<String> data) {
    setState(() {
      selectedTags = data;
    });
  }

  FutureOr<List<String>> _suggestionCallback(String text) {
    if (text.isNotEmpty) {
      return tagsData.where((String topping) {
        return topping.toLowerCase().contains(text.toLowerCase());
      }).toList();
    }
    return const <String>[];
  }

  GoogleMapController? _mapController;
  final LatLng _initialPosition =
      const LatLng(37.7749, -122.4194); // Default position (San Francisco)
  LatLng? _currentPosition;
  final Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    _checkLocationPermissions();
  }

  @override
  void dispose() {
    _currentPosition = null;
    _markers.clear();
    _mapController?.dispose();

    super.dispose();
  }

  Future<void> _checkLocationPermissions() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await _showLocationServiceDialog();
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return;
    }

    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    if (mounted) {
      setState(() {
        _currentPosition = LatLng(position.latitude, position.longitude);
        _markers.clear();
        _markers.add(Marker(
          draggable: true,
          markerId: const MarkerId("current_location"),
          position: _currentPosition!,
        ));
        _mapController?.animateCamera(
          CameraUpdate.newLatLngZoom(_currentPosition!, 14.0),
        );
      });
    }
  }

  Future<void> _showLocationServiceDialog() async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Enable Location Services"),
          content: const Text(
              "Location services are disabled. Please enable them to use this feature."),
          actions: [
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
                await Geolocator.openLocationSettings();
              },
              child: const Text("Open Settings"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Cancel"),
            ),
          ],
        );
      },
    );
  }

  void _onMapTapped(LatLng position) {
    setState(() {
      _currentPosition = position;
      _markers.clear();
      _markers.add(Marker(
        markerId: const MarkerId("new_location"),
        position: _currentPosition!,
        draggable: true,
      ));

      _mapController?.animateCamera(
        CameraUpdate.newLatLngZoom(_currentPosition!, 14.0),
      );
    });
  }

  void _addBottomSheet(String type, String title, String label) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      clipBehavior: Clip.antiAlias,
      // default is Clip.none
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
      builder: (_) {
        return DraggableScrollableSheet(
          initialChildSize: 0.6,
          maxChildSize: 0.6,
          shouldCloseOnMinExtent: false,
          expand: false,
          builder: (_, controller) {
            return Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: GoogleFonts.raleway(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: FormInputComponent(
                              controller: _drawerTextController,
                              autofocus: true,
                              hintText: label,
                              keyboardType: TextInputType.text,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: Container(
                            padding: const EdgeInsets.all(15),
                            decoration: const BoxDecoration(
                                color: Constants.primaryColor,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            child: GestureDetector(
                              child: Text(
                                "SAVE",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.raleway(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ))
                        ],
                      )
                    ],
                  ),
                ));
          },
        );
      },
    );
  }

  File? _image;
  final _picker = ImagePicker();
  Future<void> _openImagePicker() async {
    final pickedImage = await showDialog<XFile>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          icon: const Icon(Icons.image_search_rounded),
          title: Text('Select Image Source',
              style: GoogleFonts.raleway(fontSize: 20)),
          actions: [
            TextButton(
              onPressed: () async {
                Navigator.of(context)
                    .pop(await _picker.pickImage(source: ImageSource.camera));
              },
              style: const ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(Constants.primaryColor),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.camera_alt,
                    size: 12,
                    color: Colors.white,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    "Camera",
                    style:
                        GoogleFonts.raleway(fontSize: 12, color: Colors.white),
                  )
                ],
              ),
            ),
            TextButton(
              style: const ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(Constants.primaryColor),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.image,
                    size: 12,
                    color: Colors.white,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    "Gallery",
                    style:
                        GoogleFonts.raleway(fontSize: 12, color: Colors.white),
                  )
                ],
              ),
              onPressed: () async {
                Navigator.of(context)
                    .pop(await _picker.pickImage(source: ImageSource.gallery));
              },
            ),
          ],
        );
      },
    );
    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    }
  }

  void _removeImage() {
    setState(() {
      _image = null;
    });
  }

  Widget showImageDialog(File? image) {
    return SizedBox(
      child: Dialog(
        backgroundColor: Colors.white,
        child: Column(
          children: [
            const SizedBox(
              height: 15,
            ),
            Text('Image',
                style: GoogleFonts.raleway(
                    fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(
              height: 20,
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: Center(
                child: image != null
                    ? Image.file(
                        image,
                      )
                    : Container(),
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Constants.primaryColor,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.close_rounded,
                              size: 15,
                              color: Colors.white,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              "Close",
                              style: GoogleFonts.raleway(
                                  fontSize: 15, color: Colors.white),
                            )
                          ],
                        ),
                      )),
                  const SizedBox(
                    width: 5,
                  ),
                  GestureDetector(
                      onTap: () {
                        _removeImage();
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Constants.dangerColor,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.delete_sweep,
                              size: 15,
                              color: Colors.white,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              "Remove",
                              style: GoogleFonts.raleway(
                                  fontSize: 15, color: Colors.white),
                            )
                          ],
                        ),
                      ))
                ],
              ),
            ),
            const SizedBox(
              height: 25,
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: RichText(
          text: TextSpan(
            children: <TextSpan>[
              TextSpan(
                text: 'New Client',
                style: GoogleFonts.raleway(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ],
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        toolbarHeight: 70,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back_ios_new_rounded)),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.elliptical(30, 30),
                    topRight: Radius.elliptical(30, 30))),
            child: Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: FormInputComponent(
                              controller: _nameController,
                              autofocus: false,
                              hintText: "Name",
                              keyboardType: TextInputType.text,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: FormInputComponent(
                              controller: _phoneNumberController,
                              autofocus: false,
                              hintText: "Phone Number",
                              keyboardType: TextInputType.number,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: FormInputComponent(
                              controller: _phoneNumberController2,
                              autofocus: false,
                              hintText: "Phone Number 2",
                              keyboardType: TextInputType.number,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: FormInputComponent(
                              controller: _whatsappNumberController,
                              autofocus: false,
                              hintText: "Whatsapp Number",
                              keyboardType: TextInputType.number,
                            ),
                          ),
                          Checkbox(
                            fillColor:
                                const WidgetStatePropertyAll(Colors.white),
                            activeColor: Colors.grey,
                            checkColor: Colors.grey,
                            value: sameAsMobileNo,
                            focusColor: Colors.grey,
                            side:
                                const BorderSide(color: Colors.grey, width: 1),
                            onChanged: (value) {
                              setState(() {
                                sameAsMobileNo = value;
                              });
                              _whatsappNumberController.text =
                                  _phoneNumberController.text;
                            },
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: SingleDropdownComponent(
                              labelText: "Reference (Internal)",
                              items: const ["Huzaifa", "Sajid", "Sami"],
                              showSearchBox: true,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Container(
                            height: 44,
                            width: 45,
                            decoration: BoxDecoration(
                                color: Colors.grey[400],
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(10))),
                            child: IconButton(
                              onPressed: () {
                                _addBottomSheet("internal",
                                    "Add Internal Reference", "Name");
                              },
                              icon: const Icon(
                                Icons.person_add_alt_1,
                                size: 20,
                                color: Colors.white,
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: SingleDropdownComponent(
                              labelText: "Reference (External)",
                              items: const ["Huzaifa", "Sajid", "Sami"],
                              showSearchBox: true,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Container(
                            height: 44,
                            width: 45,
                            decoration: BoxDecoration(
                                color: Colors.grey[400],
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(10))),
                            child: IconButton(
                              onPressed: () {
                                _addBottomSheet("external",
                                    "Add External Reference", "Name");
                              },
                              icon: const Icon(
                                Icons.person_add_alt_1,
                                size: 20,
                                color: Colors.white,
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              children: <Widget>[
                                ChipsInput<String>(
                                  values: selectedTags,
                                  // decoration: const InputDecoration(
                                  //   prefixIcon:
                                  //       Icon(Icons.local_pizza_rounded),
                                  //   hintText: 'Search for toppings',
                                  // ),
                                  strutStyle: const StrutStyle(
                                    fontSize: 15,
                                  ),
                                  onChanged: _onChanged,
                                  onSubmitted: _onSubmitted,
                                  chipBuilder: _chipBuilder,
                                  onTextChanged: _onSearchChanged,
                                ),
                                if (_suggestions.isNotEmpty)
                                  SizedBox(
                                    height: 200,
                                    child: ListView.builder(
                                      itemCount: _suggestions.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return ToppingSuggestion(
                                          _suggestions[index],
                                          onTap: _selectSuggestion,
                                        );
                                      },
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: SingleDropdownComponent(
                              labelText: "Area",
                              items: const ["Multan", "Lahore", "Karachi"],
                              showSearchBox: true,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Container(
                            height: 44,
                            width: 45,
                            decoration: BoxDecoration(
                                color: Colors.grey[400],
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(10))),
                            child: IconButton(
                              onPressed: () {
                                _addBottomSheet(
                                    "area", "Add New Area", "Title");
                              },
                              icon: const Icon(
                                Icons.add_location_alt_rounded,
                                size: 20,
                                color: Colors.white,
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Text(
                            "Image:",
                            style: GoogleFonts.raleway(
                              fontSize: 18,
                              color: Colors.grey,
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: Container(
                            decoration: BoxDecoration(
                                color: _image == null
                                    ? Colors.grey[400]
                                    : Constants.primaryColor,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(15))),
                            child: IconButton(
                              icon: _image == null
                                  ? const Icon(
                                      Icons.camera_alt_rounded,
                                      color: Colors.white,
                                    )
                                  : const Icon(
                                      Icons.remove_red_eye,
                                      color: Colors.white,
                                    ),
                              onPressed: () {
                                if (_image != null) {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          showImageDialog(_image));
                                } else {
                                  _openImagePicker();
                                }
                              },
                            ),
                          ))
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Text(
                            "Location:",
                            style: GoogleFonts.raleway(
                              fontSize: 18,
                              color: Colors.grey,
                            ),
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: SizedBox(
                          height: 250,
                          //width: 250,
                          child: GoogleMap(
                            initialCameraPosition: CameraPosition(
                              target: _currentPosition ?? _initialPosition,
                              zoom: 5,
                            ),
                            markers: _markers,
                            onMapCreated: (GoogleMapController controller) {
                              _mapController = controller;
                              if (_currentPosition != null) {
                                _mapController?.animateCamera(
                                  CameraUpdate.newLatLngZoom(
                                      _currentPosition!, 14.0),
                                );
                              }
                            },
                            myLocationEnabled: true,
                            myLocationButtonEnabled: true,
                            onTap: _onMapTapped, // Handle tap events
                            mapToolbarEnabled: true,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                )),
          ),
        ),
      ),
      floatingActionButton: Align(
        alignment: Alignment.bottomLeft,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(25, 0, 0, 0),
          child: FloatingActionButton(
            onPressed: () {},
            backgroundColor: Colors.blue[900],
            child: const Icon(
              Icons.save_rounded,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
