enum ContentType {
  json('application/json'),
  formData('multipart/form-data'),
  formUrlEncoded('application/x-www-form-urlencoded'),
  xml('application/xml'),
  textPlain('text/plain'),
  textHtml('text/html');

  final String value;
  const ContentType(this.value);
}
