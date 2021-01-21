import 'package:cars_app/add_car.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  var carsList = List<AddNewCar>();
  var cars = List<String>();

  var _textEditingKilometerController = TextEditingController();
  var _textEditingYearController = TextEditingController();
  var _textEditingPriceController = TextEditingController();
  var _textEditingDescriptionController = TextEditingController();

  String dropdownMakerValue;
  String dropdownModelValue;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Cars"),
      ),
      body: carsList.isNotEmpty
          ? ListView.builder(
              itemCount: carsList.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Card(
                      elevation: 0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            alignment: Alignment.center,
                            child: Image.asset(
                              "assets/images/${carsList[index].modelImage}",
                              height: 150,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 10.0, bottom: 5.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${carsList[index].model} ${carModel(index)}",
                                  style: TextStyle(
                                      fontSize: 30, fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "${carsList[index].kilometer} km, ${carsList[index].year} model",
                                  style:
                                      TextStyle(fontSize: 25, color: Colors.grey),
                                ),
                                Text(
                                  "Description: ${carsList[index].description}",
                                  style:
                                      TextStyle(fontSize: 25, color: Colors.grey),
                                ),
                                Text(
                                  "Price: ${carsList[index].price} TL",
                                  style:
                                      TextStyle(fontSize: 35, color: Colors.green),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right:8.0,left: 8.0),
                      child: Divider(thickness: 2.5,color: Colors.grey,indent: 7,endIndent: 7,),
                    ),

                  ],
                );
              },
            )
          : Container(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => dialogWindow(context),
        child: Icon(Icons.add),
      ),
    );
  }

  dialogWindow(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("New Car", textAlign: TextAlign.center),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DropdownButton<String>(
                      hint: Text("Maker"),
                      value: dropdownMakerValue,
                      onChanged: (String newValue) {
                        setState(() {
                          if (newValue == "BMW") {
                            cars = bmwModels;
                          }
                          if (newValue == "Honda") {
                            cars = hondaModels;
                          }
                          if (newValue == "Mercedes") {
                            cars = mercedesModels;
                          }
                          dropdownMakerValue = newValue;
                        });
                      },
                      items:
                          maker.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                    DropdownButton<String>(
                      hint: Text("Model"),
                      value: dropdownModelValue,
                      onChanged: (String newValue) {
                        setState(() {
                          dropdownModelValue = newValue;
                        });
                      },
                      items: cars
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                    TextField(
                      keyboardType: TextInputType.number,
                      controller: _textEditingKilometerController,
                      decoration: InputDecoration(
                        labelText: "Kilometer",
                      ),
                    ),
                    TextField(
                      keyboardType: TextInputType.number,
                      controller: _textEditingYearController,
                      decoration: InputDecoration(
                        labelText: "Year",
                      ),
                    ),
                    TextField(
                      keyboardType: TextInputType.number,
                      controller: _textEditingPriceController,
                      decoration: InputDecoration(
                        labelText: "Price",
                      ),
                    ),
                    TextField(
                      controller: _textEditingDescriptionController,
                      decoration: InputDecoration(
                        labelText: "Description",
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          actions: [
            FlatButton(
              onPressed: () {
                setState(() {
                  cars=[];
                  dropdownMakerValue = null;
                  dropdownModelValue = null;
                  _textEditingKilometerController.text = "";
                  _textEditingYearController.text = "";
                  _textEditingPriceController.text = "";
                  _textEditingDescriptionController.text = "";
                });
                Navigator.pop(context);
              },
              child: Text("Cancel"),
            ),
            FlatButton(
              onPressed: () {
                if (_textEditingKilometerController.text.isNotEmpty &&
                    _textEditingYearController.text.isNotEmpty &&
                    _textEditingPriceController.text.isNotEmpty &&
                    _textEditingDescriptionController.text.isNotEmpty &&
                    dropdownMakerValue.isNotEmpty &&
                    dropdownModelValue.isNotEmpty) {
                  var car = AddNewCar(
                      _textEditingKilometerController.text,
                      _textEditingYearController.text,
                      _textEditingPriceController.text,
                      _textEditingDescriptionController.text,
                      dropdownMakerValue,
                      dropdownModelValue);

                  carsList.add(car);

                  setState(() {
                    cars=[];
                    dropdownMakerValue = null;
                    dropdownModelValue = null;
                    _textEditingKilometerController.text = "";
                    _textEditingYearController.text = "";
                    _textEditingPriceController.text = "";
                    _textEditingDescriptionController.text = "";
                    Navigator.pop(context);
                  });
                }
              },
              child: Text("Add"),
            )
          ],
        );
      },
    );
  }

  String carModel(int index) {
    String model = carsList[index].modelImage;
    String returnModel = model.substring(0, model.length - 4);
    return returnModel;
  }
}
