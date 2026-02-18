object Form1: TForm1
  Left = 226
  Top = 190
  AutoScroll = False
  Caption = 'Mozilla Firefox 3.x - 4.x Password Decryptor by ap0calypse'
  ClientHeight = 371
  ClientWidth = 573
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 464
    Top = 344
    Width = 101
    Height = 13
    Caption = 'ankasecurity.com'
    Font.Charset = TURKISH_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object BtnGetFirefoxPasswords: TButton
    Left = 8
    Top = 336
    Width = 113
    Height = 25
    Caption = 'Firefox Passwords'
    TabOrder = 0
    OnClick = BtnGetFirefoxPasswordsClick
  end
  object ListView1: TListView
    Left = 0
    Top = 0
    Width = 573
    Height = 329
    Cursor = crHandPoint
    Align = alTop
    Columns = <
      item
        Caption = 'Host'
        Width = 300
      end
      item
        Caption = 'User'
        Width = 120
      end
      item
        Caption = 'Password'
        Width = 120
      end>
    ColumnClick = False
    RowSelect = True
    TabOrder = 1
    ViewStyle = vsReport
  end
end
