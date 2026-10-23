class Loginstate {}
// LOGIN 
class Logininitial extends Loginstate {}

class Loginloading extends Loginstate {}

class Loginsecuses extends Loginstate {}

class Loginfaliuer extends Loginstate {
  final String massege;
  Loginfaliuer(this.massege);
}

