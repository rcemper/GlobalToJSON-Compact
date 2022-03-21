Class dc.GblToJSON.CX
{

ClassMethod export(
	gref As %String = "^%",
	file = "gbl.json") As %String
{
	new %gref,%file
	set %gref=gref,%file=file
	open %file:("WNS"):1 
	else  quit "File failed to create"
	use %file write "{""gbl"":["
	if $d(@%gref) do ..jsondump()
	use %file write !,"]}",!
	close %file 
	quit "File "_%file_" created"
}

ClassMethod jsondump(json = "") As %String
{
#define topspool 99999	
	open 2:$$$topspool use 2 zwrite @$ZR close 2 
	set nxt=""
	use %file
	for z=1:1 {
		quit:'$d(^SPOOL($$$topspool,z),spool)
		set spool=$replace(spool,$c(27)_"[22m","")
		set spool=$replace(spool,$c(27)_"[1m","")
		set spool=$tr(spool,$c(13,10))
		write nxt,!,"""",$ZCVT(spool,"O","JSON"),""""
		set nxt=","
		}
	kill ^SPOOL($$$topspool)	
	quit 1
}

ClassMethod import(file = "gbl.json") As %String
{
	new %val
	open file:("R"):1
	else  quit "File not found"	
	use file read line
	if line'= "{""gbl"":[" close file quit "File format error"
	for {
		read line
		if line="]}" quit
		set %val=$zCVT($e(line,2,*-(1+($e(line,*)=","))),"I","JSON")
		set @%val
		}
	close file	
	quit "Global "_$qs($zr,0)_" loaded"
}

ClassMethod show(file = "gbl.json") as %String
{
	open file:("R"):1
	else  quit "File not found"
	set $ZT="end"
	for { 
		use file read line
		use 0 write line,!
		if line="]}" quit
		}
end
	close file	
	quit "***** "_file_" *****"
}
}
