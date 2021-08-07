class Contact {

  String _title, _url, _author, _date, _imageurl, _description;


  Contact(this._title, this._url, this._author, this._date, this._imageurl,
      this._description);
  factory Contact.fromJSON(Map<String,dynamic> json) {
    if(json == null) {
      return null;
    } else {
      return Contact(json["Title"],json["url"],json["Author"],json["Date"],json["Image_url"],json["Description"]);
    }
  }
  get title => this._title;
  get url => this._url;
  get author => this._author;
  get date => this._date;
  get imageurl => this._imageurl;
  get description => this._description;
}