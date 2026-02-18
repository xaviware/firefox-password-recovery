
unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,unitFunctions, ComCtrls;

type
  TForm1 = class(TForm)
    BtnGetFirefoxPasswords: TButton;
    ListView1: TListView;
    Label1: TLabel;
    procedure BtnGetFirefoxPasswordsClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
implementation

{$R *.dfm}

procedure TForm1.BtnGetFirefoxPasswordsClick(Sender: TObject);
VAR
  Gecici :String;
  Item : TListItem;
begin
  DinamikApileriYukle;
  Gecici :=GetFirefoxPasswords;

  WHILE POS('|',Gecici)>0 DO
  BEGIN
      ITEM := LISTVIEW1.Items.ADD;
      ITEM.Caption := Copy(Gecici,1,Pos('|',Gecici)-1);
      DELETE(Gecici,1,POS('|',Gecici));
      ITEM.SubItems.Add(Copy(Gecici,1,Pos('|',Gecici)-1));
      DELETE(Gecici,1,POS('|',Gecici));
      ITEM.SubItems.Add(Copy(Gecici,1,Pos('|',Gecici)-1));
      DELETE(Gecici,1,POS('|',Gecici));
  END;
end;

end.
