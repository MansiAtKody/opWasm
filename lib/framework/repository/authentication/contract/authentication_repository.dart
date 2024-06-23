
abstract class AuthenticationRepository{

  Future loginApi(String request);

  Future forgotPasswordApi(String request);

  Future verifyOtpApi(String request);

  Future resetPasswordApi(String request);

  Future resendOtpApi(String request);

  Future deleteOperatorApi(String uuid);

  ///delete device FCM token
  Future deleteDeviceTokenApi(String deviceId);

}