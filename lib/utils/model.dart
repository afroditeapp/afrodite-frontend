/// Type for handling API null values
sealed class EditValue<T extends Object> {
  const EditValue();
  T? editedValue(T? defaultValue) => defaultValue;
  bool unsavedChanges() => false;
}

class NoEdit<T extends Object> extends EditValue<T> {
  const NoEdit();
}

class ChangeToNull<T extends Object> extends EditValue<T> {
  @override
  T? editedValue(T? defaultValue) => null;
  @override
  bool unsavedChanges() => true;
}

class ChangeToValue<T extends Object> extends EditValue<T> {
  final T value;
  const ChangeToValue(this.value);
  @override
  T? editedValue(T? defaultValue) => value;
  @override
  bool unsavedChanges() => true;
}

EditValue<T> editValue<T extends Object>(T? newValue) {
  if (newValue == null) {
    return ChangeToNull();
  } else {
    return ChangeToValue(newValue);
  }
}
