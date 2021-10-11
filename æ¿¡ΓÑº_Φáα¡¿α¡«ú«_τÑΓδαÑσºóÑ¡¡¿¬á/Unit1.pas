unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, TeEngine, Series, ExtCtrls, TeeProcs, Chart, jpeg,
  Menus;

type
  TForm1 = class(TForm)
    Button1: TButton;
    GroupBox1: TGroupBox;
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
    Image1: TImage;
    Chart1: TChart;
    Series1: TLineSeries;
    GroupBox2: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Edit7: TEdit;
    Label14: TLabel;
    Edit8: TEdit;
    Edit9: TEdit;
    Chart2: TChart;
    Series2: TLineSeries;
    Series3: TLineSeries;
    Series4: TLineSeries;
    Chart3: TChart;
    Series5: TLineSeries;
    Button2: TButton;
    Edit10: TEdit;
    Label15: TLabel;
    Edit11: TEdit;
    Edit12: TEdit;
    Label16: TLabel;
    Edit13: TEdit;
    Label17: TLabel;
    CheckBox1: TCheckBox;
    Button3: TButton;
    Label18: TLabel;
    Edit14: TEdit;
    Label19: TLabel;
    Image2: TImage;
    Label20: TLabel;
    Button4: TButton;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Chart2GetLegendText(Sender: TCustomAxisPanel;
      LegendStyle: TLegendStyle; Index: Integer; var LegendText: String);
    procedure Button2Click(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure Edit1Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure N1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;
procedure zas;
var
  Form1: TForm1;
  a,b,c:double;
implementation

uses math,zerofun,mexanic, Unit2, Unit3, Unit4;
{$R *.dfm}

const G1R=pi/180;
var fim,psim,K:double;
    A_:array[0..3] of double;
    mex2:TMexanic;
    PA,PB,PC,PD:Tpoint;
    Pr:Tpoint2;
    fi,psi,xi:double;

  procedure AxBy_C(a1,b1,c1,a2,b2,c2:double; var x,y:double);
  {������� ������� ���� a1*x+b1*y=c1
                        a2*x+b2*y=c2
  }
  var d:double;
   begin
    d:=a1*b2-a2*b1;
    x:=(c1*b2-c2*b1)/d;
    y:=(c2*a1-c1*a2)/d;
   end;

function findb(b:double):double;
begin
result:=((A_[0]*b+A_[1])*b+A_[2])*b+A_[3];
end;

function Alf_TCos(a,b,c:double):double;
//c^2=a^2+b^2-2*a*b*cos(alf)
begin
result:=arccos((a*a+b*b-c*c)/2/a/b);
end;

function C2_TCos(a,b,alf:double):double;
//c^2=a^2+b^2-2*a*b*cos(alf)
begin
result:=a*a+b*b-2*a*b*cos(alf);
end;

procedure Treug(Xb_Xd,Yb_Yd,li,lj:double; var fi1,fi2,fj1,fj2:double); overload;
var gam,alf,Lbd:double;
begin
 Lbd:=hypot(Xb_Xd,Yb_Yd);
 gam:=arctan2(Yb_Yd,Xb_Xd);
 alf:=arccos((Lbd*Lbd+lj*lj-li*li)/2/lj/Lbd);
 fj1:=gam-alf;
 fj2:=gam+alf;
 alf:=arccos((Lbd*Lbd+li*li-lj*lj)/2/li/Lbd);
 gam:=gam-pi;
 fi1:=gam+alf;
 fi2:=gam-alf;
end;

procedure Treug(Xb_Xd,Yb_Yd,li,lj:double; var f:array of double); overload;
begin
Treug(Xb_Xd,Yb_Yd,li,lj,f[0],f[1],f[2],f[3]);
end;

procedure DiadaWWW_P(Xb,Yb,Xd,Yd,li,lj:double; var f:array of double);
var Xdb,Ydb,Ldb,gam,alf:double;
    i:integer;
begin
 Xdb:=Xd-Xb; Ydb:=Yd-Yb;
 Ldb:=hypot(Xdb,Ydb);
 gam:=arctan2(Ydb,Xdb);
 alf:=arccos((Ldb*Ldb+li*li-lj*lj)/2/li/Ldb);
 f[0]:=gam-alf;
 f[1]:=gam+alf;
 for i:=0 to 1 do
 f[i+2]:=arctan2(Yb+li*sin(f[i])-Yd,Xb+li*cos(f[i])-Xd);
end;

procedure rismex;
begin
 Pr:=Point2_(a,fi);  //B
 PB:=P2_Point(PA,Pr);
 Pr:=Point2(1,0);  //D
 PD:=P2_Point(PA,Pr);
 PC:=P2_Point(PA,Point2_(Pr,c,psi));
 mex2.Mex2WWWW([PA,PB,PC,PD]);
end;

procedure TForm1.Button1Click(Sender: TObject);
var x,z,Mu,r,r1,r2,r3,sx,sz,sz_x,cz_x:double;
    bmin,bmax,s2z_x:double;
    m:integer;
    bm:array[1..4] of double;
    dfi,mas0:double;
begin
N1.Enabled:=true;
 button3.Enabled:=false;
 button4.Enabled:=false;
 label20.Caption:='���� ��������� ���������������� ��������� �� ������� ����';
 image2.Visible:=false;
 image1.Visible:=true;
 image1.Canvas.FillRect(rect(0,0,image1.Width,image1.Height));
 series1.Clear;
 series2.Clear;
 series3.Clear;
 series4.Clear;
 series5.Clear;
 if tag=0 then
 begin
  fim:=strtofloat(edit1.Text)*G1R;
  K:=fim/(2*pi-fim);
  edit7.Text:=floattostr(K);
 end
 else
 begin
  K:=strtofloat(edit7.Text);
  fim:=2*pi*K/(1+K);
  edit1.Text:=floattostr(fim/G1R);
 end;
 tag:=0;
 psim:=strtofloat(edit2.Text)*G1R;
  x:=psim/2;
  z:=fim/2;
  sx:=sin(x);
  sz:=sin(z);
  r:=z-x;
  sz_x:=sin(r);
  cz_x:=cos(r);
  bmin:=sx;
  bmax:=sx*sz/abs(cz_x);
  edit8.Text:=format('%0.4f',[bmin]);
  edit9.Text:=format('%0.4f',[bmax]);
  s2z_x:=sin(2*z-x);
  r:=sqr(cz_x);
  A_[0]:=sqr(s2z_x)*r;
  r1:=sqr(sz);
  r2:=sqr(cos(z));
  A_[1]:=r1*(-3*sqr(r)+2*r2*r+r2);
  r3:=sqr(sx);
  A_[2]:=r3*r1;
  A_[3]:=-sqr(A_[2]);
  A_[2]:=A_[2]*((2+r1)*r-2*r2);
  b:=bmin;
 while b<=bmax do
  begin
  series1.AddXY(b,findb(b));
  b:=b+0.001;
  end;
 // exit;
  //������� ��������� ��� b
  m:=0;
  ppmetod(bmin,bmax,1.0e-25,0.01,findb,m,bm);
  if m=0 then
  begin
   with form3 do
   begin
    label6.Caption:=format('%0.1f',[(pi+psim)/2/G1R]);
    label7.Caption:=format('%0.1f',[(3*pi+psim)/2/G1R]);
    label10.Caption:=format('%0.1f',[(pi+psim)/(3*pi-psim)]);
    label11.Caption:=format('%0.1f',[(3*pi+psim)/(pi-psim)]);
   end;
   form3.showmodal;
   exit;
  end;
  if m>1 then
  showmessage('��� �����!');
  b:=sqrt(bm[1]);
  a:=sqrt(r3-b*b*r)/sz_x;
  c:=sqrt(r1-b*b*s2z_x/sx)/sz_x;
  mu:=arccos((2*a+b*b+c*c-1-a*a)/2/b/c);
  edit3.Text:=format('%0.4f',[a]);
  edit4.Text:=format('%0.4f',[mu/G1R]);
  edit5.Text:=format('%0.4f',[b]);
  edit6.Text:=format('%0.4f',[c]);
  r1:=pi-Alf_TCos(c,1,a+b);
  r2:=pi-Alf_TCos(c,1,b-a);
  edit12.Text:=format('%0.4f',[r2/G1R]);
  edit13.Text:=format('%0.4f',[r1/G1R]);
  r1:=Alf_TCos(1,a+b,c);
  r2:=Alf_TCos(1,b-a,c)+pi;
  edit10.Text:=format('%0.4f',[r2/G1R]);
  edit11.Text:=format('%0.4f',[r1/G1R]);
  k:=round((r2-r1)/0.2);
  dfi:=(r2-r1)/k;
  fi:=r1;
  m:=0;
  mas0:=masx;
  sx:=c*masx/y000;
  if sx>1 then mex2.masxy(masx/(1.07*sx));
  sx:=a*masx/x000;
  if sx>1 then mex2.masxy(masx/(1.07*sx));
  while fi<=r2+dfi/2 do
  begin
  inc(m);
 //  treug(a*cos(fi)-1,a*sin(fi),b,c,bm);  //?
   diadaWWW_P(a*cos(fi),a*sin(fi),1,0,b,c,bm);
   psi:=bm[4];
   xi:=bm[2];  //gam
   series2.AddXY(fi,psi);
   sx:=sin(xi); x:=cos(xi);
   sz:=sin(psi); z:=cos(psi);
   sz_x:=sin(fi); cz_x:=cos(fi);
   AxBy_C(c*sz,-b*sx,a*sz_x,c*z,-b*x,a*cz_x,r,r3);
   series3.AddXY(fi,r);
   AxBy_C(c*sz,-b*sx,a*cz_x+b*x*r3*r3-c*z*r*r,c*z,-b*x,c*sz*r*r-a*sz_x-b*sx*r3*r3,r,r3);
   series4.AddXY(fi,r);

   r3:=C2_TCos(1,a,fi);
   r:=Alf_TCos(b,c,sqrt(r3));
   series5.AddXY(fi,r/G1R);
   with form2.StringGrid1 do
   begin
    cells[0,m]:=inttostr(m);
    cells[1,m]:=format('%0.4f',[fi/G1R]);
    cells[2,m]:=format('%0.4f',[psi/G1R]);
    cells[3,m]:=format('%0.4f',[r/G1R]);
    cells[4,m]:=format('%0.4f',[xi/G1R]);
   end;
   if checkbox1.Checked then
   mex2.Canvas.Pen.Color:=RGB(random(255),random(255),random(255))
   else
   mex2.Canvas.Pen.Color:=clblack;
   rismex;
   fi:=fi+dfi;
  end;
  masx:=mas0;
  masy:=mas0;
  form2.StringGrid1.RowCount:=m+2;
 button3.Enabled:=true;
 button4.Enabled:=true;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
 mex2:=TMexanic.Create;
 mex2.SetCanvas(image1.Canvas);
 mex2.masxy(180.0);
 x000:=120;
 y000:=200;
 PA.X:=x000;
 PA.Y:=y000;
 decimalseparator:='.';
 fim:=strtofloat(edit1.Text)*pi/180;
 psim:=strtofloat(edit2.Text)*pi/180;
 K:=fim/(2*pi-fim);
 edit7.Text:=floattostr(K);
 label15.Caption:=#163+'  j  '+#163;
 label16.Caption:=#163+'  y  '+#163;
 //image2.Picture.LoadFromFile('1.bmp');
 label20.Caption:='�������� ����� ��������� ���������� ���������������';
end;

procedure TForm1.Chart2GetLegendText(Sender: TCustomAxisPanel;
  LegendStyle: TLegendStyle; Index: Integer; var LegendText: String);
begin
 case index of
 0:legendtext:='y(j)';
 1:legendtext:='y'+#162+'(j)';
 2:legendtext:='y'+#178+'(j)';
 end;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
close;
end;

procedure TForm1.CheckBox1Click(Sender: TObject);
begin
if tag=2 then exit;
button1Click(self);
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
 form2.show;
end;

procedure TForm1.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
if (sender as TEdit).Name='Edit1' then
tag:=0 else
tag:=1;
case key of
'0'..'9','.',#8:exit;
else key:=#0;
end;
end;

procedure TForm1.Edit1Click(Sender: TObject);
begin
 image1.Visible:=false;
 image2.Visible:=true;
 label20.Caption:='�������� ����� ��������� ���������� ���������������';
end;

procedure TForm1.Button4Click(Sender: TObject);
const n=48;
var
    bm:array[1..4] of double;
    dfi:double;
begin
 tag:=2;
 image2.Visible:=false;
 image1.Visible:=true;
 label20.Caption:='�������� ��������� ���������� ���������������';
 image1.Canvas.FillRect(rect(0,0,image1.Width,image1.Height));
 fi:=0;
 dfi:=2*pi/n;
  while fi<=2*pi+dfi/2 do
  begin
 //  treug(a*cos(fi)-1,a*sin(fi),b,c,bm);  //?
   diadaWWW_P(a*cos(fi),a*sin(fi),1,0,b,c,bm);
   psi:=bm[4];
   xi:=bm[2];  //gam
    mex2.Canvas.Pen.Color:=clblack;
    rismex;
   // delay_wait(50);
    sleep(50); application.ProcessMessages;
    if checkbox1.Checked then
    mex2.Canvas.Pen.Color:=clSkyblue
    else
    mex2.Canvas.Pen.Color:=image1.Canvas.Brush.Color;
    rismex;
   fi:=fi+dfi;
  end;
   fi:=fi-dfi;
    mex2.Canvas.Pen.Color:=clblack;
    rismex;
end;

procedure zas;
begin
form4.Edit4.Text:=form1.Edit4.Text;
form4.Edit3.Text:=form1.Edit3.Text;
form4.Edit5.Text:=form1.Edit5.Text;
form4.Edit6.Text:=form1.Edit6.Text;
form4.Edit14.Text:=form1.Edit14.Text;
end;

procedure TForm1.N1Click(Sender: TObject);
begin
zas;
form4.show;
end;

end.
