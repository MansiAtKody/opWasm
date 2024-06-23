
abstract class RobotTraySelectionRepository{

  Future robotListApi(String request, int pageNo);

  Future addItemToTrayApi(String request);

  Future deleteItemFromTrayApi(String uuid);

  Future getTrayListApi(String robotUuid, int trayNumber);

}