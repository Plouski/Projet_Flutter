class Task{
  //Class properties
  int? _id;
  String? _name;
  String? _description;
  String? _tarif;
  String? _adresse;
  String? _cp;
  String? _ville;
  String? _rayon;
  bool _completed=false;
  Task(this._name,this._description,this._rayon,this._tarif,this._adresse,this._cp,this._ville);
  /*
  new Task("task 1");
  new Task("task 2");
   */
  //Getter and setter for id
setId(id)=>this._id=id;
getId()=>this._id;
//Getter and setter for name
getName()=>this._name;
setName(name)=>this._name=name;
//Getter and setter for description
getDescription()=>this._description;
setDescription(description)=>this._description=description;
//Getter and setter for tarif
getTarif()=>this._tarif;
setTarif(tarif)=>this._tarif=tarif;
//Getter and setter for adresse
getAdresse()=>this._adresse;
setAdresse(adresse)=>this._adresse=adresse;
//Getter and setter for CP
getCP()=>this._cp;
setCP(CP)=>this._cp=CP;
//Getter and setter for ville
getVille()=>this._cp;
setVille(ville)=>this._cp=ville;
//Getter and setter for rayon
getRayon()=>this._rayon;
setRayon(rayon)=>this._rayon=rayon;
}