Class dc.GblToJSON.C
{

ClassMethod do(gref As %String = "^%") As %DynamicObject
{
	new %gref
	set %gref=gref
	set json={}
	if $d(@%gref) set json=..json()
	quit json
}

ClassMethod json(json = "") As %DynamicObject
{
#define topspool 99999	
	open 2:$$$topspool use 2 zwrite @$ZR close 2 
	set json={}
	set json.gbl=[]	
	for z=1:1 {
		quit:'$d(^SPOOL($$$topspool,z),spool)
		set spool=$replace(spool,$c(27)_"[22m","")
		set spool=$replace(spool,$c(27)_"[1m","")
		set spool=$tr(spool,$c(13,10))
		do json.gbl.%Push(spool)
		}
	kill ^SPOOL($$$topspool)	
	quit json
}

ClassMethod load(json As %DynamicObject) As %Status
{
	set gbl=json.gbl
	set sc=0
	if gbl.%IsA("%Library.DynamicArray") {
		set iter=gbl.%GetIterator()
		new %val
		while iter.%GetNext(.key , .%val ) { set @%val }
		set sc=1
		}
	quit sc
}

}
