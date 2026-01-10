enum PetMood { sleeping, ecstatic, happy, okay, worried, upset }

extension PetMoodExt on PetMood {
  String get headline {
    return switch (this) {
      PetMood.sleeping => 'resting',
      PetMood.ecstatic => 'thriving',
      PetMood.happy => 'happy',
      PetMood.okay => 'okay',
      PetMood.worried => 'a bit worried',
      PetMood.upset => 'not feeling great',
    };
  }
}
