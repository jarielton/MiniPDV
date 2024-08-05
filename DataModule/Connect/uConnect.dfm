object dmX: TdmX
  OnCreate = DataModuleCreate
  Height = 480
  Width = 640
  object Conn: TFDConnection
    Params.Strings = (
      'OpenMode=ReadWrite'
      'LockingMode=Normal'
      'DriverID=SQLite')
    LoginPrompt = False
    Left = 144
    Top = 56
  end
end
