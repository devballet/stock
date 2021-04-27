import "package:scoped_model/scoped_model.dart";


/// ********************************************************************************************************************
/// Base class that the model for all entities extend.
/// ********************************************************************************************************************
class BaseModel extends Model {


  /// Which page of the stack is currently showing.
  int stackIndex = 0;


  /// The list of entities.
  List dtoList = [ ];


  /// The entity being edited.
  


  /// The date chosen by the user.  Needed to be able to display what the user picks on the entry screen.
  String chosenDate;


  /// For display of the date chosen by the user.
  ///
  /// @param inDate The date in MM/DD/YYYY form.
  void setChosenDate(String inDate) {

    print("## BaseModel.setChosenDate(): inDate = $inDate");

    chosenDate = inDate;
    notifyListeners();

  } /* End setChosenDate(). */


  /// Load data from database.
  ///
  /// @param inEntityType The type of entity being loaded ("appointments", "contacts", "notes" or "tasks").
  /// @param inDatabase   The DBProvider.db instance for the entity.
  void loadData(String inEntityType, dynamic inDatabase) async {
    print("## ${inEntityType}Model.loadData()");
    dtoList = await inDatabase.getAll();
    notifyListeners();

  } /* End loadData(). */

  void setStackIndex(int inStackIndex) {

    print("## BaseModel.setStackIndex(): inStackIndex = $inStackIndex");

    stackIndex = inStackIndex;
    notifyListeners();

  } /* End setStackIndex(). */

  void setNoti()
  {
    notifyListeners();
  }


} /* End class. */
