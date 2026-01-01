#Requires AutoHotkey v2
#SingleInstance force
OnClipboardChange Using_MPC_BE

LastKey := ""
layer(key := "", key2 := "", HotKey := GetHotKey()) {
	global LastKey := InStr("vk1c vk1d", HotKey) ? HotKey : ""
	key ? Send("{Blind}{" key " Down}") : ""
	KeyWait HotKey
	key ? Send("{Blind}{" key " Up}") : ""	
	HotKey := LastKey = HotKey ? "" : HotKey
	A_PriorKey = HotKey && key2 ? Send("{Blind}" key2) : ""
}
GetHotKey(Trg := A_ThisHotKey, HotKey := LTrim(trg, "+*``")) =>
	InStr(HotKey, " up") ? SubStr(HotKey, 1, -3) : HotKey

Duplex(key := "", key2 := "", trg := "") =>
	SenW(WithKey(key, key2, trg), key2) ||
	trg || !key2 || KeyWait(GetHotKey(), "T0.2") ? "" : SenW(key2)

SenW(key := "", trg := key) =>
	Send("{Blind}" key) || trg = key ? KeyWait(GetHotKey()) : ""

Arpeggio(key := "", key2 := "", trg := GetHotKey()) =>
	Send("{Blind}" (trg = GetHotKey(A_PriorHotKey) ? key2 : key))

WithKey(key := "", key2 := "", trg := "") =>
	trg && GetKeyState(trg, "P") ? key2 : key

Prim(str) => GetKeyState("Ctrl", "P") ? "{Ctrl Up}" str "{Ctrl Down}" : str

Using_MPC_BE(*) => InStr(A_Clipboard, "youtu") &&
	Run("C:\Program Files\MPC-BE\mpc-be64.exe " A_Clipboard)

Search(url) => Send("^{c}") || Sleep(100) || Run(url . A_Clipboard)

Notice(str, delay := 1000) => ToolTip(str) && SetTimer(ToolTip, -delay)

*-::
*^::
*\::
*t::
*y::
*@::
*[::
*]::
*b::
*Esc::
*Tab::
*vkE2::
*LShift::return

w::l
e::u
r::f

a::e
s::i
d::a
f::o
g::-

z::x
x::c
c::v
v::,

u::r
i::y
o::h
p::w

h::p
j::t
k::n
*l::Duplex("k", "n", "k")
`;::s
vkBA::j

n::b
m::d
,::m
.::g
/::z

*vk1d::Layer(, "{Enter}")
*Space::Layer("Shift", "{Space}")
*vk1c::Layer(, "{BackSpace}")
*Delete::Layer(, "{Delete}")

#HotIf GetKeyState("LShift", "P")
*u::Arpeggio("{{}", "{Left}{{}", "i")
*i::Arpeggio("{}}", "{}}{Left}", "u")
*o::Arpeggio("[", "{Left}[", "p")
*p::Arpeggio("]", "]{Left}", "o")

h::Home
j::PgDn
k::Pgup
l::End
`;::@
vkBA::`

n::#
m::%
,::^
.::~
/::\

#HotIf GetKeyState("Space", "P")
g::+

v::|

#HotIf GetKeyState("Delete", "P")
q::F11
w::F1
e::F2
r::F3

a::F10
s::F4
d::F5
f::F6

LShift::F12
z::F7
x::F8
c::F9

u::Search("https://www.google.com/search?q=")
i::Search("https://www.oxfordlearnersdictionaries.com/definition/english/")
o::Search("https://www.etymonline.com/search?q=")
p::Search("https://translate.google.com/?sl=auto&tl=ja&text=")

h::Run("https://drive.google.com/drive/u/0/my-drive")
j::Run("https://x.com/husino93/with_replies")
k::Run("https://bsky.app/profile/489wiki.bsky.social")
l::Run("https://typingch.c4on.jp/game/index.html")
`;::Run("https://keyx0.net/easy/")
vkBA::Run("https://o24.works/atc/")

m::Run("C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Notepad++.lnk")

#HotIf GetKeyState("vk1c", "P")
q::/
w::Duplex(1, "{BS}*", "q")
e::2
r::3

a::0
s::4
d::5
f::6

z::7
x::8
c::9
v::.

*u::Arpeggio("(", "{Left}(", "i")
*i::Arpeggio(")", "){Left}", "u")
*o::Arpeggio("=", "{Left}<", "p")
p::>

h::Left
j::Down
k::Up
l::Right
*;::Arpeggio('"', '"{Left}')
*vkBA::Arpeggio("'", "'{Left}")

n::_
m::!
,::?
.:::
/::;

#HotIf GetKeyState("vk1d", "P")
q::!F4
*w::Click("WU")
*e::Click("WD")
*r::Send(KeyWait("r", "T0.2") ? "!^f" : "!+f") || KeyWait("r")

a::Tab
*s::Layer("Click R")
*d::Layer("Click")
f::F13

LShift::!Tab
z::Esc
x::vk5D
c::+F14

#SuspendExempt true
u::Reload
i::Suspend(-1) || Notice("サスペンド " (A_IsSuspended ? "ON" : "OFF"))

#SuspendExempt false
*o::Arpeggio("{vkf2}{vkf3}", "{Esc}")
*p::Arpeggio("{vkf2}", "{Esc}")

*h::
*j::
*k::
*l:: {
	MouseGetPos(&X, &Y)
	diff := GetKeyState("Ctrl", "P") ? 80 : 16
	X += GetKeyState("l", "P") ? diff : (GetKeyState("h", "P") ? -diff : 0)
	Y += GetKeyState("j", "P") ? diff : (GetKeyState("k", "P") ? -diff : 0)
	MouseMove(X, Y)
}
`;:: {
	WinGetPos(&X, &Y, &W, &H, "A")
	MouseGetPos(&offsetX, &offsetY)
	MX := Min(W, 1920 - X), MY := Min(H, 1080 - Y)
	◢ := (offsetY / MY + offsetX / MX) > 1
	◣ := (offsetY / MY - offsetX / MX) > 0
	MouseMove((◢ / 2 + !◢ * ◣) * MX, (!◢ / 2 + ◢ * !◣) * MY)
	Notice("ルパインアタック", 300)
}
vkBA:: {
	TargetHWnd := WinActive("A")
	MyGui := Gui()
	MyGui.AddDateTime().SetFormat("'Date:' MM/dd/yyyy 'Time:' hh:mm:ss tt")
	MyGui.AddMonthCal()
	MyGui.OnEvent("Close", (*) => MyGui.Destroy())
	MyGui.Show("X500")
	WinActivate(TargetHWnd)
}

n::Browser_Home
m::Volume_mute
,::Volume_Down
.::Volume_Up
/::KeyHistory

*vk1c::global LastKey := Send("{End}{Enter}")

#HotIf WinExist("ahk_exe AutoHotkey64.exe")
*w::Duplex("l", "{BS}ɫ")
*e::Duplex("u", "{BS}ʊ")

*LControl::Layer("Ctrl", "ə")
*a::Duplex("e", "{BS}ɛ")
*s::Duplex("i", "{BS}ɪ")
*d::Duplex(WithKey("a", "æ", "Ctrl"), WithKey("{BS}ɑ",, "Ctrl"))
*f::Duplex("o", "{BS}ɔ")
*g::Duplex(WithKey("ː", "ˈ", "Ctrl"), WithKey(, Prim("{BS}ˌ"), "Ctrl"))
*c::Duplex("v", "{BS}ʌ")

*u::Duplex(WithKey("r", "ɚ", "Ctrl"), Prim("{BS}" WithKey("ɹ", "ɝ", "Ctrl")))
*o::!GetKeyState("j", "P") && !GetKeyState(";", "P") ? Duplex("h", "{BS}ɾ")
	: Duplex("{BS}" WithKey("ʃ", "θ", "j"), "{BS}" WithKey("tʃ", "ð", "j"))

*l::Duplex("k", "{BS}ŋk", "k")
*vkBA::Duplex("j", "{BS}ʒ")

*.::Duplex("g", "{BS}ŋ", "k")

#HotIf WinActive("ahk_exe RPG_RT.exe")
*h::Layer("Left")
*j::Layer("Down")
*k::Layer("Up")
*l::Layer("Right")
*x::Layer("x")
*z::Layer("z")

Notice("終わったよ", 800)
