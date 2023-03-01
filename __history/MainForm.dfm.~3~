object Form1: TForm1
  Left = 299
  Top = 148
  Caption = 'Compactar arquivos e pastas'
  ClientHeight = 385
  ClientWidth = 634
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesigned
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter1: TSplitter
    Left = 303
    Top = 0
    Height = 385
    Align = alRight
    ExplicitLeft = 321
    ExplicitTop = 156
    ExplicitHeight = 100
  end
  object ListBox1: TListBox
    Left = 306
    Top = 0
    Width = 328
    Height = 385
    Align = alRight
    ItemHeight = 13
    TabOrder = 0
  end
  object cmdOpenFoF: TButton
    Left = 8
    Top = 12
    Width = 173
    Height = 25
    Caption = 'Abrir Arquivos ou Pasta'
    TabOrder = 1
    OnClick = cmdOpenFoFClick
  end
  object cmdClearList: TButton
    Left = 213
    Top = 12
    Width = 75
    Height = 25
    Caption = 'Limpar Lista'
    TabOrder = 2
    OnClick = cmdClearListClick
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 51
    Width = 280
    Height = 115
    Caption = 'Abrir Arquivos ou Pastas'
    TabOrder = 3
    object rbFiles: TRadioButton
      Left = 12
      Top = 24
      Width = 113
      Height = 17
      Caption = 'Arquivos'
      Checked = True
      TabOrder = 0
      TabStop = True
    end
    object rbFolders: TRadioButton
      Left = 12
      Top = 60
      Width = 113
      Height = 17
      Caption = 'Pastas'
      TabOrder = 1
    end
  end
  object GroupBox2: TGroupBox
    Left = 8
    Top = 177
    Width = 280
    Height = 145
    Caption = 'Zip type selector'
    TabOrder = 4
    object Label1: TLabel
      Left = 12
      Top = 87
      Width = 99
      Height = 13
      Caption = 'Nome do Arquivo Zip'
      Enabled = False
    end
    object rbSeparate: TRadioButton
      Left = 12
      Top = 24
      Width = 113
      Height = 17
      Caption = 'Separate separate'
      Checked = True
      TabOrder = 0
      TabStop = True
      OnClick = rbSeparateClick
    end
    object rboneFile: TRadioButton
      Left = 12
      Top = 54
      Width = 113
      Height = 17
      Caption = 'Zipar um Arquivo'
      TabOrder = 1
      OnClick = rbOneFileClick
    end
    object Edit1: TEdit
      Left = 12
      Top = 103
      Width = 121
      Height = 21
      Enabled = False
      TabOrder = 2
    end
  end
  object cmdZip: TButton
    Left = 8
    Top = 342
    Width = 280
    Height = 25
    Caption = 'Zip'
    TabOrder = 5
    OnClick = cmdZipClick
  end
  object FileOpenDialog1: TFileOpenDialog
    DefaultFolder = '.\'
    FavoriteLinks = <>
    FileTypes = <>
    Options = [fdoAllowMultiSelect]
    Left = 207
    Top = 243
  end
end
