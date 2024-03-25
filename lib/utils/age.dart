

const MIN_AGE = 18;
const MAX_AGE = 99;

bool ageIsValid(int? age) {
  return age != null && age >= MIN_AGE && age <= MAX_AGE;
}


bool ageRangeIsValid(int? min, int? max) {
  return min != null && max != null && min <= max && ageIsValid(min) && ageIsValid(max);
}
