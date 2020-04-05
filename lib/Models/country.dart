class Country {
  final String name;
  final String codeName;
  final String dialCode;
  final String language;
  final int digitsCount;

  Country({
    this.name,
    this.codeName,
    this.dialCode,
    this.language,
    this.digitsCount,
  });

  static List<Country> getCountryLangs() {
    return <Country>[
      Country(
        codeName: "AZ",
        language: "Azerbaycan",
        name: "Azerbaijan",
      ),
      Country(
        codeName: "CZ",
        language: "Cestina",
        name: "Czech Republic",
      ),
      Country(
        codeName: "DK",
        language: "Danish",
        name: "Denmark",
      ),
      Country(
        codeName: "DE",
        language: "Deutsch",
        name: "Germany",
      ),
      Country(
        codeName: "FR",
        language: "French",
        name: "France",
      ),
      Country(
        codeName: "MY",
        language: "Malaysia",
        name: "Malaysia",
      ),
      Country(
        codeName: "MX",
        language: "Espanol - Mexico",
        name: "Mexico",
      ),
      Country(
        codeName: "MZ",
        language: "Mozambique",
        name: "Mozambique",
      ),
      Country(
        codeName: "PT",
        language: "Portugues",
        name: "Portugal",
      ),
      Country(
        codeName: "RO",
        language: "Romana",
        name: "Romania",
      ),
      Country(
        codeName: "RS",
        language: "Srpski",
        name: "Serbia",
      ),
      Country(
        codeName: "ES",
        language: "Espanol - Espana",
        name: "Spain",
      ),
      Country(
        codeName: "TZ",
        language: "Swahili",
        name: "Tanzania",
      ),
      Country(
        codeName: "US",
        language: "English - US",
        name: "United States",
      ),
      Country(
        codeName: "GB",
        language: "English - UK",
        name: "United Kingdom",
      ),
    ];
  }

  static List<Country> getCountryCodes() {
    return <Country>[
//      Country(
//        codeName: "AZ",
//        dialCode: "",
//        name: "Azerbaijan",
//      ),
//      Country(
//        codeName: "CZ",
//        dialCode: "",
//        name: "Czech Republic",
//      ),
      Country(
        codeName: "CA",
        dialCode: "+1",
        name: "Canada",
      ),
//      Country(
//        codeName: "DK",
//        dialCode: "",
//        name: "Denmark",
//      ),
//      Country(
//        codeName: "DE",
//        dialCode: "",
//        name: "Germany",
//      ),
//      Country(
//        codeName: "FR",
//        dialCode: "",
//        name: "France",
//      ),
//      Country(
//        codeName: "MY",
//        dialCode: "",
//        name: "Malaysia",
//      ),
//      Country(
//        codeName: "MX",
//        dialCode: "",
//        name: "Mexico",
//      ),
//      Country(
//        codeName: "MZ",
//        dialCode: "",
//        name: "Mozambique",
//      ),
      Country(
        codeName: "NG",
        dialCode: "+234",
        digitsCount: 10,
        name: "Mozambique",
      ),
//      Country(
//        codeName: "PT",
//        dialCode: "",
//        name: "Portugal",
//      ),
//      Country(
//        codeName: "RO",
//        dialCode: "",
//        name: "Romania",
//      ),
//      Country(
//        codeName: "RS",
//        dialCode: "",
//        name: "Serbia",
//      ),
//      Country(
//        codeName: "ES",
//        dialCode: "",
//        name: "Spain",
//      ),
//      Country(
//        codeName: "TZ",
//        dialCode: "",
//        name: "Tanzania",
//      ),
      Country(
        codeName: "US",
        dialCode: "+1",
        name: "United States",
      ),
      Country(
        codeName: "GB",
        dialCode: "+44",
        name: "United Kingdom",
      ),
    ];
  }
}
