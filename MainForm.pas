unit MainForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, FWZipWriter, ExtCtrls;

type
  TForm1 = class(TForm)
    ListBox1: TListBox;
    cmdOpenFoF: TButton;
    cmdClearList: TButton;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    rbFiles: TRadioButton;
    rbFolders: TRadioButton;
    rbSeparate: TRadioButton;
    rboneFile: TRadioButton;
    Label1: TLabel;
    Edit1: TEdit;
    cmdZip: TButton;
    FileOpenDialog1: TFileOpenDialog;
    Splitter1: TSplitter;
    procedure cmdClearListClick(Sender: TObject);
    procedure cmdOpenFoFClick(Sender: TObject);
    procedure rbSeparateClick(Sender: TObject);
    procedure rboneFileClick(Sender: TObject);
    procedure cmdZipClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
   LoadedFiles:TStringList;
implementation

{$R *.dfm}

procedure TForm1.cmdClearListClick(Sender: TObject);
begin
ListBox1.Items.Clear;
LoadedFiles.Clear;
end;

procedure TForm1.cmdOpenFoFClick(Sender: TObject);
var
i:Integer;
begin
  if rbFiles.Checked=true then
    FileOpenDialog1.Options:=FileOpenDialog1.Options-[fdoPickFolders];
  if rbFiles.Checked=false then
    FileOpenDialog1.Options:=FileOpenDialog1.Options+[fdoPickFolders];

  if FileOpenDialog1.Execute then
  begin

  for I := 0 to FileOpenDialog1.Files.Count - 1 do
  begin
   ListBox1.Items.Add(ExtractFileName(FileOpenDialog1.Files[i]));
   LoadedFiles.Add(FileOpenDialog1.Files[i]);
  end;
   Edit1.Text:=ExtractFileName(FileOpenDialog1.FileName);
  end;

//now I have to create stringlist to handle full file names
end;

//now looks good, let's test
procedure TForm1.cmdZipClick(Sender: TObject);
var
  FName,FNameOfSel,ZippedRoot:WideString;
  i:Integer;
  S:TStringStream;
  PresentFiles:TStringList;
  SR:TSearchRec;
  Zip:TFWZipWriter;
  BuildZipResult:TBuildZipResult;
begin
    Screen.Cursor:=crHourGlass;
    ZippedRoot:=ExpandFileName(ExtractFileDir(FileOpenDialog1.FileName));

  if rbSeparate.Checked=true then
  begin

    for I := 0 to LoadedFiles.Count - 1 do
    begin
      Zip:=TFWZipWriter.Create;
      Zip.UseUTF8String:=True;
      FName:=LoadedFiles[i];
      FNameOfSel:=ExtractFileName(FName);

        if DirectoryExists(FName)=false then
        begin
          SetCurrentDir(ZippedRoot+'\');
          S:=TStringStream.Create(FName);
          S.Position:=0;
          Zip.AddStream(FNameOfSel,S);
          S.Free;
          BuildZipResult:=Zip.BuildZip(ZippedRoot+'\'+FNameOfSel+'.zip');
          ForceDirectories(ZippedRoot+'\');
          Zip.Free;

        end;

      if DirectoryExists(FName)=true then
      begin
        SetCurrentDir(FName);
        PresentFiles:=TStringList.Create;
      if Zip.AddFolder('..\'+FNameOfSel+'\')=0 then
       raise Exception.Create('Error adding data');

      if FindFirst(FName+'*.*',faAnyFile,SR)=0 then
      repeat
       if (SR.Name='.') or (SR.Name='..') then  Continue;
       PresentFiles.Add('AddFilesAndFolders\'+SR.Name+'=..\..\'+SR.Name);
      until FindNext(SR)<>0;
        FindClose(SR);
        Zip.AddFilesAndFolders(PresentFiles,True);
        PresentFiles.Free;
        BuildZipResult:=Zip.BuildZip(ZippedRoot+'\'+FNameOfSel+'.zip');
        ForceDirectories(ZippedRoot+'\');
        Zip.Free;
      end;

    end;

  end;

    if rbSeparate.Checked=false then //ups
    begin
      Zip:=TFWZipWriter.Create;
      Zip.UseUTF8String:=True;

      for I := 0 to LoadedFiles.Count - 1 do
      begin
           FName:=LoadedFiles[i];
           FNameOfSel:=ExtractFileName(FName);

          if DirectoryExists(FName)=false then
          begin
            SetCurrentDir(ZippedRoot+'\');
            S:=TStringStream.Create(FName);
            S.Position:=0;
            Zip.AddStream(FNameOfSel,S);
            S.Free;
            ForceDirectories(ZippedRoot+'\');
          end;

          if DirectoryExists(FName)=true then
         begin
               SetCurrentDir(FName);
               PresentFiles:=TStringList.Create;
            if Zip.AddFolder('..\'+FNameOfSel+'\')=0 then
            raise Exception.Create('Error adding data');

            if FindFirst(FName+'*.*',faAnyFile,SR)=0 then
            repeat
             if (SR.Name='.') or (SR.Name='..') then  Continue;
             PresentFiles.Add('AddFilesAndFolders\'+SR.Name+'=..\..\'+SR.Name);
            until FindNext(SR)<>0;
              FindClose(SR);
              Zip.AddFilesAndFolders(PresentFiles,True);
              PresentFiles.Free;
              ForceDirectories(ZippedRoot+'\');
         end;

      end;
     BuildZipResult:=Zip.BuildZip(ZippedRoot+'\'+Edit1.Text+'.zip');
     ForceDirectories(ZippedRoot+'\');
     Zip.Free;
    end;

    Screen.Cursor:=crDefault;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  LoadedFiles.Free;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  LoadedFiles:=TStringList.Create;  //No No No !!!!
end;

procedure TForm1.rboneFileClick(Sender: TObject);
begin
  Edit1.Enabled:=True;
  Label1.Enabled:=True;
end;

procedure TForm1.rbSeparateClick(Sender: TObject);
begin
  Edit1.Enabled:=False;
  Label1.Enabled:=False;
end;

end.



