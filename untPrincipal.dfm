object FrmFonetica: TFrmFonetica
  Left = 0
  Top = 0
  Caption = 'Fon'#233'tica'
  ClientHeight = 115
  ClientWidth = 341
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 40
    Top = 37
    Width = 36
    Height = 13
    Caption = 'Original'
  end
  object Label2: TLabel
    Left = 176
    Top = 37
    Width = 80
    Height = 13
    Caption = 'C'#243'digo Fon'#233'tico '
  end
  object edtEntrada: TEdit
    Left = 40
    Top = 56
    Width = 121
    Height = 21
    TabOrder = 0
    OnChange = edtEntradaChange
  end
  object edtSaida: TEdit
    Left = 176
    Top = 56
    Width = 121
    Height = 21
    ReadOnly = True
    TabOrder = 1
  end
end
