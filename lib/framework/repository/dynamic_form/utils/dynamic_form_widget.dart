import 'package:kody_operator/framework/repository/dynamic_form/repository/model/dynamic_form_response_model.dart';
import 'package:kody_operator/ui/utils/const/app_enums.dart';
import 'package:kody_operator/ui/utils/theme/theme.dart';

class DynamicFormWidget extends StatelessWidget {
  final DynamicFormData? responseData;
  final GlobalKey<FormState> formKey;

  const DynamicFormWidget({super.key, required this.responseData, required this.formKey});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          responseData?.fields?.where((element) => element.type == DynamicFormWidgetsEnumNew.image.name).isNotEmpty ?? false
              ? Expanded(
                  child: ListView(
                    shrinkWrap: true,
                    children: List.generate(
                      responseData?.fields?.length ?? 0,
                      (fieldIndex) {
                        return (responseData?.fields?[fieldIndex].listWidget.isNotEmpty ?? false)
                            ? Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: List.generate(
                                  (responseData?.fields?[fieldIndex].isLanguageEffected ?? false) ? (responseData?.activeLanguages?.length ?? 0) : 1,
                                  (languageIndex) {
                                    if (responseData?.fields?[fieldIndex].type != DynamicFormWidgetsEnumNew.image.name) {
                                      return const Offstage();
                                    }
                                    return responseData?.fields?[fieldIndex].listWidget[languageIndex][WidgetPropertyEnum.widget] ?? const Offstage();
                                  },
                                ),
                              )
                            : const Offstage();
                      },
                    ),
                  ),
                )
              : const Offstage(),
          SizedBox(width: 5.w),
          Expanded(
            flex: 3,
            child: ListView(
              shrinkWrap: true,
              children: List.generate(
                responseData?.fields?.length ?? 0,
                (fieldIndex) {
                  return (responseData?.fields?[fieldIndex].listWidget.isNotEmpty ?? false)
                      ? Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: List.generate(
                            (responseData?.fields?[fieldIndex].isLanguageEffected ?? false) ? (responseData?.activeLanguages?.length ?? 0) : 1,
                            (languageIndex) {
                              if (responseData?.fields?[fieldIndex].type == DynamicFormWidgetsEnumNew.image.name) {
                                return const Offstage();
                              }
                              return responseData?.fields?[fieldIndex].listWidget[languageIndex][WidgetPropertyEnum.widget] ?? const Offstage();
                            },
                          ),
                        )
                      : const Offstage();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
