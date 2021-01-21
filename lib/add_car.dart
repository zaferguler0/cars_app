List<String> maker = ["BMW","Honda","Mercedes"];

List<String> bmwModels = ["3-series.png","7-series.png","X1.png","X2.png","X3.png"];
List<String> hondaModels = ["Civic.png","CR-V.png","Jazz.png"];
List<String> mercedesModels = ["A-class.png","E-class.png","G-class.png","Maybach.png"];

class AddNewCar{

  final kilometer;
  final year;
  final price;
  final model;
  final modelImage;
  final description;

  AddNewCar(this.kilometer, this.year, this.price,  this.description, this.model, this.modelImage);

}