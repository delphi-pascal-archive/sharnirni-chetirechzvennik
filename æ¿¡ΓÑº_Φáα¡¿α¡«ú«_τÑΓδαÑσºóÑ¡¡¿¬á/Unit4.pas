unit Unit4;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm4 = class(TForm)
    Label5: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label6: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    Edit6: TEdit;
    Label19: TLabel;
    Edit14: TEdit;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Edit3KeyPress(Sender: TObject; var Key: Char);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form4: TForm4;

implementation

uses unit1;

{$R *.dfm}

var flag:byte=0;

procedure TForm4.Button2Click(Sender: TObject);
begin
flag:=0;
Close;
end;

procedure TForm4.Button1Click(Sender: TObject);
begin
zas;
end;

procedure TForm4.FormShow(Sender: TObject);
begin
button2.SetFocus;
end;

procedure TForm4.Edit3KeyPress(Sender: TObject; var Key: Char);
begin
if (sender as TEdit).Name='Edit5' then flag:=2 else
if (sender as TEdit).Name='Edit3' then flag:=1 else
if (sender as TEdit).Name='Edit6' then flag:=1 else
if (sender as TEdit).Name='Edit14' then flag:=4;
if not button3.Enabled then button3.Enabled:=true;
case key of
'0'..'9','.',#8:exit;
end;
end;

procedure TForm4.Button3Click(Sender: TObject);
var k:double;
begin
button3.Enabled:=false;
case flag of
1:k:=strtofloat(edit3.Text)/a;
2:k:=strtofloat(edit5.Text)/b;
3:k:=strtofloat(edit6.Text)/c;
4:k:=strtofloat(edit14.Text);
end;
edit3.Text:=format('%0.4f',[a*k]);
edit5.Text:=format('%0.4f',[b*k]);
edit6.Text:=format('%0.4f',[c*k]);
edit14.Text:=format('%0.4f',[k]);
flag:=0;
end;

end.
