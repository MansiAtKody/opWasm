
class DynamicFormUIStateNew<DynamicFormResponseModel> {
  DynamicFormUIStateNew({
    this.isLoading = false,
    this.success,
  });

  bool isLoading;
  DynamicFormResponseModel? success;
}
