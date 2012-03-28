set val(chan)           Channel/WirelessChannel    ;# channel type
set val(prop)           Propagation/Shadowing2   ;# radio-propagation model
set val(netif)          Phy/WirelessPhy            ;# network interface type
set val(mac)            Mac/802_11                 ;# MAC type
set val(ifq)            Queue/DropTail/PriQueue    ;# interface queue type
set val(ll)             LL                         ;# link layer type
set val(ant)            Antenna/OmniAntenna        ;# antenna model
set val(ifqlen)         1000000                         ;# max packet in ifq
set val(nn)             12                     ;# number of mobilenodes
set val(rp)		DSR			;#routing protocol
set val(x)              950  			   ;# X dimension of topography
set val(y)              500			   ;# Y dimension of topography  
#set val(stop)		150			   ;# time of simulation end

# set up the antennas to be centered in the node and 1.5 meters above it
Antenna/OmniAntenna set X_ 0
Antenna/OmniAntenna set Y_ 0
Antenna/OmniAntenna set Z_ 2.0
Antenna/OmniAntenna set Gt_ 1.0
Antenna/OmniAntenna set Gr_ 1.0 




set ns [new Simulator]
set tracefd       [open isai.tr w]
set windowVsTime2 [open isai.tr w]
# Create a nam trace datafile.
set namfile [open topo.nam w]
$ns namtrace-all $namfile


$ns trace-all $tracefd

# ----- Setup wireless environment. ----
set wireless_tracefile [open topo.trace w]
set topography [new Topography]
$ns trace-all $wireless_tracefile
$ns namtrace-all-wireless $namfile $val(x) $val(y)

# set up topography object
set topo       [new Topography]

$topo load_flatgrid $val(x) $val(y)

set f1		[open "type1" "r"]
set f2		[open "type2" "r"]
set f3          [open "ip" "r"]
set f5          [open "type4" "r"]
set pic1        [open "pic" "r"] 
create-god $val(nn)


# configure the nodes
        $ns node-config -adhocRouting $val(rp) \
			 -llType $val(ll) \
			 -macType $val(mac) \
			 -ifqType $val(ifq) \
			 -ifqLen $val(ifqlen) \
			 -antType $val(ant) \
			 -propType $val(prop) \
			 -phyType $val(netif) \
			 -channelType $val(chan) \
			 -topoInstance $topo \
			 -agentTrace ON \
			 -routerTrace ON \
			 -macTrace OFF \
			 -movementTrace ON
			 
# Create wireless nodes.
set node(0) [$ns node]

$node(0) set X_ 200.0
$node(0) set Y_ 700.0
$node(0) set Z_ 0.0

$ns at 0.0 "$node(0) label MASTER1"
$ns initial_node_pos $node(0) 40.000000
set node(1) [$ns node]

$node(1) set X_ 50.0
$node(1) set Y_ 600.0
$node(1) set Z_ 0.0
$node(1) color "black"
$ns initial_node_pos $node(1) 30.000000

set node(2) [$ns node]
$node(2) set X_ 350.0
$node(2) set Y_ 600.0
$node(2) set Z_ 0.0
$node(2) color "black"
$ns initial_node_pos $node(2) 30.000000

set node(3) [$ns node]
$node(3) set X_ -50
$node(3) set Y_ 500.0
$node(3) set Z_ 0.0
$node(3) color "black"
$ns initial_node_pos $node(3) 40.000000

set node(4) [$ns node]
$node(4) set X_ 150
$node(4) set Y_ 500.0
$node(4) set Z_ 0.0
$node(4) color "black"
$ns initial_node_pos $node(4) 30.000000

set node(5) [$ns node]
$node(5) set X_ 300.0
$node(5) set Y_ 500.0
$node(5) set Z_ 0.0

$ns at 0.0 "$node(5) label SLAVEBRIDGE"
$ns initial_node_pos $node(5) 30.000000

set node(6) [$ns node]
$node(6) set X_ 450.0
$node(6) set Y_ 500.0
$node(6) set Z_ 0.0
$node(6) color "black"
$ns initial_node_pos $node(6) 40.000000

set node(7) [$ns node]
$node(7) set X_ -150.0
$node(7) set Y_ 400.0
$node(7) set Z_ 0.0
$node(7) color "black"
$ns initial_node_pos $node(7) 40.000000

set node(8) [$ns node]
$node(8) set X_ 10.0
$node(8) set Y_ 400.0
$node(8) set Z_ 0.0
$node(8) color "black"
$ns initial_node_pos $node(8) 30.000000

set node(9) [$ns node]
$node(9) set X_ 70.0
$node(9) set Y_ 400.0
$node(9) set Z_ 0.0
$node(9) color red
$ns initial_node_pos $node(9) 40.000000

set node(10) [$ns node]
$node(10) set X_ 210.0
$node(10) set Y_ 400.0
$node(10) set Z_ 0.0



$ns at 0.0 "$node(10) label MASTER2"
$ns initial_node_pos $node(10) 40.000000

for {set k 0} {$k <= 2} {incr k} {
set l($k) [gets $f5 data2($k)]
}

#puts "the output is $l(1)"
#set fn [gets $f5 data(1)]
#set tn [gets $f5 data(2)]

#puts "first $data(0)"
#puts "second $data(1)"

#set l [gets $f5 dat1]
for {set r 0} {$r < $data2(0)} {incr r} {
set I($r) [$ns node]
set kl [expr 100.0 * $r]
$I($r) set X_ $kl  
$I($r) set Y_ 100 
$I($r) set Z_ 0.0
$ns at 0.0 "$I($r) add-mark m1 yellow circle"
$ns at 0.0 "$I($r) add-mark m2 yellow circle"
$ns at 0.0 "$I($r) label OBJECT-$r "
$ns initial_node_pos $I($r) 40.000000  
}

#diff mobid file 
for {set k 0} {$k < 2} {incr k} {
set p [gets $f1 data($k)]
}
#set I [$ns node]
#$I [IR(0)] 
#puts "The given mobile_id differs from the mobile_ids of nodes in the network"
switch $data(1) {
    0 {
		set x	200.0
		set y	700.0
                set tcp [new Agent/TCP/Newreno]
                 set sink [new Agent/TCPSink]
                 $tcp set class_ 1
                 $ns attach-agent $node(4) $tcp
                 $ns attach-agent $node(0) $sink
                 $ns connect $tcp $sink
                 set ftp [new Application/FTP]
                 $ftp attach-agent $tcp
                 $tcp set packetSize_ 2000
                 $ns at 0.79 "$ftp start" 
                 $ns at 1.22 "$ftp stop" 
                 $ns at 0.8 "$I(0) delete-mark m1"
                 $ns at 0.8 "$I(0) delete-mark m2"
                 $ns at 0.81 "$I(0) add-mark m1 red circle"
                 $ns at 0.81 "$I(0) add-mark m2 red circle"
                 $ns at 0.81 "$ns trace-annotate \"Data flows from node-4 to Master-1\""
                 $ns at 0.81 "$ns trace-annotate \"Intruder is Detected due to different mobile id\""
                 $ns at 0.81 "$I(0) label NEWNODE"


     }
   1 {
		set x   50.0
		set y	600
                set tcp [new Agent/TCP/Newreno]
                 set sink [new Agent/TCPSink]
                 $tcp set class_ 1
                 $ns attach-agent $node(1) $tcp
                 $ns attach-agent $node(0) $sink
                 $ns connect $tcp $sink
		 set ftp [new Application/FTP]
                 $tcp set packetSize_ 2000
                 $ftp attach-agent $tcp
                 $ns at 0.8 "$ftp start" 
                 $ns at 1.22 "$ftp stop" 
                 $ns at 0.8 "$I delete-mark m1"
                 $ns at 0.8 "$I delete-mark m2"
                 $ns at 0.82 "$I add-mark m1 red circle"
                 $ns at 0.82 "$I add-mark m2 red circle"
                 $ns at 0.82 "$ns trace-annotate \"Data flows from node-1 to Master-1\""
                 $ns at 0.82 "$ns trace-annotate \"Intruder is Detected due to different mobile id\""
                 $ns at 0.82 "$I label INTRUDER"
                 
     }
   2 {
		set x	 350.0
        	set y	 600
                set tcp [new Agent/TCP/Newreno]
                 $tcp set class_ 1
                 set sink [new Agent/TCPSink]
                 $ns attach-agent $node(1) $tcp
                 $ns attach-agent $node(0) $sink
                 $ns connect $tcp $sink
		set ftp [new Application/FTP]
                 $tcp set packetSize_ 2000
                 $ftp attach-agent $tcp
                 $ns at 0.88 "$ftp start" 
                 $ns at 1.28 "$ftp stop"
                 $ns at 0.88 "$I(0) delete-mark m1"
                 $ns at 0.88 "$I(0) delete-mark m2"
                 $ns at 0.89 "$I(0) add-mark m1 red circle"
                 $ns at 0.89 "$I(0) add-mark m2 red circle"
                 $ns at 0.89 "$ns trace-annotate \"Data flows from node-1 to Master-1\""
                 $ns at 0.89 "$ns trace-annotate \"Intruder is Detected due to different mobile id\""
                 $ns at 0.89 "$I(0) label INTRUDER" 
         
     } 	
   3 {
		set x	-50
		set y	500
                set tcp [new Agent/TCP/Newreno]
                 set sink [new Agent/TCPSink]
                 $tcp set class_ 1
                 $ns attach-agent $node(4) $tcp
                 $ns attach-agent $node(0) $sink
                 $ns connect $tcp $sink
		 set ftp [new Application/FTP]
                 $tcp set packetSize_ 2000
                 $ftp attach-agent $tcp
                 $ns at 0.7 "$ftp start" 
                 $ns at 1.15 "$ftp stop" 
                 $ns at 0.7 "$I(0) delete-mark m1"
                 $ns at 0.7 "$I(0) delete-mark m2"
                 $ns at 0.72 "$I(0) add-mark m1 red circle"
                 $ns at 0.72 "$I(0) add-mark m2 red circle"
                 $ns at 0.72 "$ns trace-annotate \"Data flows from node-4 to Master-1\""
                 $ns at 0.72 "$ns trace-annotate \"Intruder is Detected due to different mobile id\""
                 $ns at 0.72 "$I label INTRUDER"
     }	
  
   4 {           set x	150
		 set y	500
                 set tcp [new Agent/TCP/Newreno]
                 set sink [new Agent/TCPSink]
                 $tcp set class_ 1
                 $ns attach-agent $node(4) $tcp
                 $ns attach-agent $node(0) $sink
                 $ns connect $tcp $sink	
		 set ftp [new Application/FTP]
                 $tcp set packetSize_ 2000
                 $ftp attach-agent $tcp
                 $ns at 0.7 "$ftp start" 
                 $ns at 1.15 "$ftp stop" 
                 $ns at 0.7 "$I(0) delete-mark m1"
                 $ns at 0.7 "$I(0) delete-mark m2"
                 $ns at 0.72 "$I(0) add-mark m1 red circle"
                 $ns at 0.72 "$I(0) add-mark m2 red circle"
                 $ns at 0.72 "$ns trace-annotate \"Data flows from node-4 to Master-1\""
                 $ns at 0.72 "$ns trace-annotate \"Intruder is Detected due to different mobile id\""
                 $ns at 0.72 "$I(0) label INTRUDER"
 	}	
    5 {
		set x	300
		set y	500
                set tcp [new Agent/TCP/Newreno]
                 set sink [new Agent/TCPSink]
                 $tcp set class_ 1
                 $ns attach-agent $node(4) $tcp
                 $ns attach-agent $node(0) $sink
                 $ns connect $tcp $sink
		 set ftp [new Application/FTP]
                 $ftp attach-agent $tcp
                 $tcp set packetSize_ 2000
                 $ns at 0.77 "$ftp start" 
                 $ns at 1.22 "$ftp stop" 
                  
                 $ns at 0.77 "$I(0) delete-mark m1"
                 $ns at 0.77 "$I(0)  delete-mark m2"
                 $ns at 0.79 "$I(0) add-mark m1 red circle"
                 $ns at 0.79 "$I(0) add-mark m2 red circle"
                 $ns at 0.79 "$ns trace-annotate \"Data flows from node-4 to Master-1\""
                 $ns at 0.79 "$ns trace-annotate \"Intruder is Detected due to different mobile id\""
                 $ns at 0.79 "$I(0) label INTRUDER"
     }
   6 {
		set x	450
        	set y	500
                 set tcp [new Agent/TCP/Newreno]
                 set sink [new Agent/TCPSink]
                 $tcp set class_ 1
                 $ns attach-agent $node(6) $tcp
                 $ns attach-agent $node(10) $sink
                 $ns connect $tcp $sink
		set ftp [new Application/FTP]
                 $ftp attach-agent $tcp
                 $tcp set packetSize_ 2000
                 $ns at 1.1 "$ftp start" 
                 $ns at 1.53 "$ftp stop" 
                 $ns at 1.1 "$I(0) delete-mark m1"
                 $ns at 1.1 "$I(0) delete-mark m2"
                 $ns at 1.12 "$I(0) add-mark m1 red circle"
                 $ns at 1.12 "$I(0) add-mark m2 red circle"
                 $ns at 1.12 "$ns trace-annotate \"Data flows from node-6 to Master-2\""
                 $ns at 1.12 "$ns trace-annotate \"Intruder is Detected due to different mobile id\""
                 $ns at 1.12 "$I(0) label INTRUDER"
     } 	
   7 {
		set x	-150
		set y	500
                set tcp [new Agent/TCP/Newreno]
                 set sink [new Agent/TCPSink]
                 $tcp set class_ 1
                 $ns attach-agent $node(4) $tcp
                 $ns attach-agent $node(0) $sink
                 $ns connect $tcp $sink
		set ftp [new Application/FTP]
                 $ftp attach-agent $tcp
                 $tcp set packetSize_ 2000
                 $ns at 0.84 "$ftp start" 
                 $ns at 1.2 "$ftp stop" 
                 $ns at 0.84 "$I(0) delete-mark m1"
                 $ns at 0.84 "$I(0) delete-mark m2"
                 $ns at 0.86 "$I(0) add-mark m1 red circle"
                 $ns at 0.86 "$I(0) add-mark m2 red circle"
                 $ns at 0.86 "$ns trace-annotate \"Data flows from node-4 to Master-1\""
                 $ns at 0.86 "$ns trace-annotate \"Intruder is Detected due to different mobile id\""
                 $ns at 0.86 "$I(0) label INTRUDER"

     }	
  
   8 {           set x	10
		 set y	400
                 set tcp [new Agent/TCP/Newreno]
                 set sink [new Agent/TCPSink]
                 $tcp set class_ 1
                 $ns attach-agent $node(6) $tcp
                 $ns attach-agent $node(10) $sink
                 $ns connect $tcp $sink
		set ftp [new Application/FTP]
                 $ftp attach-agent $tcp
                 $tcp set packetSize_ 2000
                 $ns at 1.13 "$ftp start" 
                 $ns at 1.53 "$ftp stop" 
                 $ns at 1.13 "$I(0) delete-mark m1"
                 $ns at 1.13 "$I(0) delete-mark m2"
                 $ns at 1.15 "$I(0) add-mark m1 red circle"
                 $ns at 1.15 "$I(0) add-mark m2 red circle"
                 $ns at 1.15 "$ns trace-annotate \"Data flows from node-6 to Master-2\""
                 $ns at 1.15 "$ns trace-annotate \"Intruder is Detected due to different mobile id\""
                 $ns at 1.15 "$I(0) label INTRUDER"
     
 	}	

 9 {
		set x	70
		set y	400
                set tcp [new Agent/TCP/Newreno]
                 set sink [new Agent/TCPSink]
                  $tcp set class_ 1
                 $ns attach-agent $node(9) $tcp
                 $ns attach-agent $node(10) $sink
                 $ns connect $tcp $sink
		 set ftp [new Application/FTP]
                 $ftp attach-agent $tcp
                 $tcp set packetSize_ 1000
                 $ns at 1.73 "$ftp start" 
                 $ns at 2.13 "$ftp stop" 
                 $ns at 1.73 "$I(0) delete-mark m1"
                 $ns at 1.73 "$I(0) delete-mark m2"
                 $ns at 1.75 "$I(0) add-mark m1 red circle"
                 $ns at 1.75 "$I(0) add-mark m2 red circle"
                 $ns at 1.75 "$ns trace-annotate \"Data flows from node-9 to Master-2\""
                 $ns at 1.75 "$ns trace-annotate \"Intruder is Detected due to different mobile id\""
                 $ns at 1.75 "$I(0) label INTRUDER"
                
     }	

  10 {
		set x	210
		set y	400
                set tcp [new Agent/TCP/Newreno]
                 set sink [new Agent/TCPSink]
                 $tcp set class_ 1
                 $ns attach-agent $node(6) $tcp
                 $ns attach-agent $node(10) $sink
                 $ns connect $tcp $sink
		set ftp [new Application/FTP]
                 $ftp attach-agent $tcp
                 $tcp set packetSize_ 2000
                 $ns at 1.13 "$ftp start" 
                 $ns at 1.53 "$ftp stop" 
                 $ns at 1.13 "$I(0) delete-mark m1"
                 $ns at 1.13 "$I(0) delete-mark m2"
                 $ns at 1.15 "$I(0) add-mark m1 red circle"
                 $ns at 1.15 "$I(0) add-mark m2 red circle"
                 $ns at 1.15 "$ns trace-annotate \"Data flows from node-6 to Master-2\""
                 $ns at 1.15 "$ns trace-annotate \"Intruder is Detected due to different mobile id\""
                 $ns at 1.15 "$I(0) label INTRUDER"
     }	
}


#same mobidkk
for {set k 0} {$k < $data2(0)*3} {incr k} {
set r [gets $f2 data1($k)]
}
set p [expr 0]
for {set v 0} {$v < $data2(0) * 2} {set v [expr {$v + 2}]} {
switch $data1($v) {
    0 {
		set x	150.0
		set y	350.0
                set tcp [new Agent/TCP/Newreno]
                 set sink [new Agent/TCPSink]
                 $tcp set class_ 1
                 $ns attach-agent $node(4) $tcp
                 $ns attach-agent $node(0) $sink
                 $ns connect $tcp $sink
                 set ftp [new Application/FTP]
                 $ftp attach-agent $tcp
                 $tcp set packetSize_ 2000
                 $ns at 0.79 "$ftp start" 
                 $ns at 1.22 "$ftp stop" 
                 $ns at 0.8 "$I($p) delete-mark m1"
                 $ns at 0.8 "$I($p) delete-mark m2"
                 $ns at 0.81 "$I($p) add-mark m1 red circle"
                 $ns at 0.81 "$I($p) add-mark m2 red circle"
                 $ns at 0.81 "$ns trace-annotate \"Data flows from node-4 to Master-1\""
                 $ns at 0.81 "$ns trace-annotate \"New node is Detected due to different mobile id\""
                 $ns at 0.81 "$I($p) label NEW_NODE"
     }
   1 {
		set x   0.0
		set y   200
                set tcp [new Agent/TCP/Newreno]
                 set sink [new Agent/TCPSink]
                 $tcp set class_ 1
                 $ns attach-agent $node(1) $tcp
                 $ns attach-agent $node(0) $sink
                 $ns connect $tcp $sink
		 set ftp [new Application/FTP]
                 $tcp set packetSize_ 2000
                 $ftp attach-agent $tcp
                 $ns at 0.8 "$ftp start" 
                 $ns at 1.22 "$ftp stop" 
                 $ns at 0.8 "$I($p) delete-mark m1"
                 $ns at 0.8 "$I($p) delete-mark m2"
                 $ns at 0.82 "$I($p) add-mark m1 red circle"
                 $ns at 0.82 "$I($p) add-mark m2 red circle"
                 $ns at 0.82 "$ns trace-annotate \"Data flows from node-1 to Master-1\""
                 $ns at 0.82 "$ns trace-annotate \"New Node is Detected due to different ip address\""
                 $ns at 0.82 "$I($p) label New_Node"
     }
   2 {
		set x	 0.0
        	set y	 500
                set tcp [new Agent/TCP/Newreno]
                 $tcp set class_ 1
                 set sink [new Agent/TCPSink]
                 $ns attach-agent $node(1) $tcp
                 $ns attach-agent $node(0) $sink
                 $ns connect $tcp $sink
		set ftp [new Application/FTP]
                 $tcp set packetSize_ 2000
                 $ftp attach-agent $tcp
                 $ns at 0.88 "$ftp start" 
                 $ns at 1.28 "$ftp stop"
                 $ns at 0.88 "$I($p) delete-mark m1"
                 $ns at 0.88 "$I($p) delete-mark m2"
                 $ns at 0.89 "$I($p) add-mark m1 red circle"
                 $ns at 0.89 "$I($p) add-mark m2 red circle"
                 $ns at 0.89 "$ns trace-annotate \"Data flows from node-1 to Master-1\""
                 $ns at 0.89 "$ns trace-annotate \"New Node is Detected due to different ip address\""
                 $ns at 0.89 "$I($p) label New_Node" 
     } 	
   3 {
		set x	300
		set y	500
                set tcp [new Agent/TCP/Newreno]
                 set sink [new Agent/TCPSink]
                 $tcp set class_ 1
                 $ns attach-agent $node(4) $tcp
                 $ns attach-agent $node(0) $sink
                 $ns connect $tcp $sink
		 set ftp [new Application/FTP]
                 $tcp set packetSize_ 2000
                 $ftp attach-agent $tcp
                 $ns at 0.7 "$ftp start" 
                 $ns at 1.15 "$ftp stop" 
                 $ns at 0.7 "$I($p) delete-mark m1"
                 $ns at 0.7 "$I($p) delete-mark m2"
                 $ns at 0.72 "$I($p) add-mark m1 red circle"
                 $ns at 0.72 "$I($p) add-mark m2 red circle"
                 $ns at 0.72 "$ns trace-annotate \"Data flows from node-4 to Master-1\""
                 $ns at 0.72 "$ns trace-annotate \"New Node is Detected due to different ip address\""
                 $ns at 0.72 "$I($p) label New_Node"
		
    }	
  
   4 {          set x	300
		 set y	200
                 set tcp [new Agent/TCP/Newreno]
                 set sink [new Agent/TCPSink]
                 $tcp set class_ 1
                 $ns attach-agent $node(4) $tcp
                 $ns attach-agent $node(0) $sink
                 $ns connect $tcp $sink	
		set ftp [new Application/FTP]
                  $tcp set packetSize_ 2000
                 $ftp attach-agent $tcp
                $ns at 0.7 "$ftp start" 
                 $ns at 1.15 "$ftp stop" 
                 $ns at 0.7 "$I($p) delete-mark m1"
                 $ns at 0.7 "$I($p) delete-mark m2"
                 $ns at 0.72 "$I($p) add-mark m1 red circle"
                 $ns at 0.72 "$I($p) add-mark m2 red circle"
                 $ns at 0.72 "$ns trace-annotate \"Data flows from node-4 to Master-1\""
                 $ns at 0.72 "$ns trace-annotate \"New Node is Detected due to different ip address\""
                 $ns at 0.72 "$I($p) label New_node"
     
 	}	
    5 {
		set x	450
		set y	350
                set tcp [new Agent/TCP/Newreno]
                 set sink [new Agent/TCPSink]
                 $tcp set class_ 1
                 $ns attach-agent $node(4) $tcp
                 $ns attach-agent $node(0) $sink
                 $ns connect $tcp $sink
		set ftp [new Application/FTP]
                 $ftp attach-agent $tcp
                 $tcp set packetSize_ 2000
                 $ns at 0.77 "$ftp start" 
                 $ns at 1.22 "$ftp stop" 
                  
                 $ns at 0.77 "$I($p) delete-mark m1"
                 $ns at 0.77 "$I($p) delete-mark m2"
                 $ns at 0.79 "$I($p) add-mark m1 red circle"
                 $ns at 0.79 "$I($p) add-mark m2 red circle"
                 $ns at 0.79 "$ns trace-annotate \"Data flows from node-4 to Master-1\""
                 $ns at 0.79 "$ns trace-annotate \"New Node is Detected due to different ip address\""
                 $ns at 0.79 "$I($p) label New_Node"
     }
   6 {
		set x	600
        	set y	200
                 set tcp [new Agent/TCP/Newreno]
                 set sink [new Agent/TCPSink]
                 $tcp set class_ 1
                 $ns attach-agent $node(6) $tcp
                 $ns attach-agent $node(10) $sink
                 $ns connect $tcp $sink
		set ftp [new Application/FTP]
                 $ftp attach-agent $tcp
                 $tcp set packetSize_ 2000
                 $ns at 1.1 "$ftp start" 
                 $ns at 1.53 "$ftp stop" 
                 $ns at 1.1 "$I($p) delete-mark m1"
                 $ns at 1.1 "$I($p) delete-mark m2"
                 $ns at 1.12 "$I($p) add-mark m1 red circle"
                 $ns at 1.12 "$I($p) add-mark m2 red circle"
                 $ns at 1.12 "$ns trace-annotate \"Data flows from node-6 to Master-2\""
                 $ns at 1.12 "$ns trace-annotate \"New Node is Detected due to different ip address\""
                 $ns at 1.12 "$I($p) label New_Node"
     } 	
   7 {
		set x	600
		set y	500
                set tcp [new Agent/TCP/Newreno]
                 set sink [new Agent/TCPSink]
                 $tcp set class_ 1
                 $ns attach-agent $node(4) $tcp
                 $ns attach-agent $node(0) $sink
                 $ns connect $tcp $sink
		set ftp [new Application/FTP]
                 $ftp attach-agent $tcp
                 $tcp set packetSize_ 2000
                 $ns at 0.84 "$ftp start" 
                 $ns at 1.2 "$ftp stop" 
                 $ns at 0.84 "$I($p) delete-mark m1"
                 $ns at 0.84 "$I($p) delete-mark m2"
                 $ns at 0.86 "$I($p) add-mark m1 red circle"
                 $ns at 0.86 "$I($p) add-mark m2 red circle"
                 $ns at 0.86 "$ns trace-annotate \"Data flows from node-4 to Master-1\""
                 $ns at 0.86 "$ns trace-annotate \"New node is Detected due to different ip address\""
                 $ns at 0.86 "$I($p) label New_Node"

     }	
  
   8 {           set x	900
		 set y	500
                 set tcp [new Agent/TCP/Newreno]
                 set sink [new Agent/TCPSink]
                 $tcp set class_ 1
                 $ns attach-agent $node(6) $tcp
                 $ns attach-agent $node(10) $sink
                 $ns connect $tcp $sink
		set ftp [new Application/FTP]
                 $ftp attach-agent $tcp
                 $tcp set packetSize_ 2000
                 $ns at 1.13 "$ftp start" 
                 $ns at 1.53 "$ftp stop" 
                 $ns at 1.13 "$I($p) delete-mark m1"
                 $ns at 1.13 "$I($p) delete-mark m2"
                 $ns at 1.15 "$I($p) add-mark m1 red circle"
                 $ns at 1.15 "$I($p) add-mark m2 red circle"
                 $ns at 1.15 "$ns trace-annotate \"Data flows from node-6 to Master-2\""
                 $ns at 1.15 "$ns trace-annotate \"New Node is Detected due to different ip address\""
                 $ns at 1.15 "$I($p) label New_Node"
     
 	}	

 9 {
		set x	900
		set y	200
                set tcp [new Agent/TCP/Newreno]
                 set sink [new Agent/TCPSink]
                  $tcp set class_ 1
                 $ns attach-agent $node(9) $tcp
                 $ns attach-agent $node(10) $sink
                 $ns connect $tcp $sink
		 set ftp [new Application/FTP]
                 $ftp attach-agent $tcp
                 $tcp set packetSize_ 1000
                 $ns at 1.73 "$ftp start" 
                 $ns at 2.13 "$ftp stop" 
                 $ns at 1.73 "$I($p) delete-mark m1"
                 $ns at 1.73 "$I($p) delete-mark m2"
                 $ns at 1.75 "$I($p) add-mark m1 red circle"
                 $ns at 1.75 "$I($p) add-mark m2 red circle"
                 $ns at 1.75 "$ns trace-annotate \"Data flows from node-9 to Master-2\""
                 $ns at 1.75 "$ns trace-annotate \"New Node is Detected due to different ip address\""
                 $ns at 1.75 "$I($p) label new_Node"
     }	

  10 {
		set x	750
		set y	350
                set tcp [new Agent/TCP/Newreno]
                 set sink [new Agent/TCPSink]
                 $tcp set class_ 1
                 $ns attach-agent $node(6) $tcp
                 $ns attach-agent $node(10) $sink
                 $ns connect $tcp $sink
		set ftp [new Application/FTP]
                 $ftp attach-agent $tcp
                 $tcp set packetSize_ 2000
                $ns at 1.13 "$ftp start" 
                 $ns at 1.53 "$ftp stop" 
                 $ns at 1.13 "$I($p) delete-mark m1"
                 $ns at 1.13 "$I($p) delete-mark m2"
                 $ns at 1.15 "$I($p) add-mark m1 red circle"
                 $ns at 1.15 "$I($p) add-mark m2 red circle"
                 $ns at 1.15 "$ns trace-annotate \"Data flows from node-6 to Master-2\""
                 $ns at 1.15 "$ns trace-annotate \"New Node is Detected due to different ip address\""
                 $ns at 1.15 "$I($p) label New_Node"
     }	
}
# incr p
# puts data1[$p]
$ns at 0.2 "$I($p) setdest [expr $x+50] [expr $y-10]  450.0"
incr p
}

$ns color 0 Brown

set tcp [new Agent/TCP/Newreno]
$tcp set class_ 2
set sink [new Agent/TCPSink]
$ns attach-agent $node($data2(1)) $tcp
$ns attach-agent $node(0) $sink
$ns connect $tcp $sink
set ftp [new Application/FTP]
$ftp attach-agent $tcp
$ns at 0.0 "$ftp start"
$ns at 1.0 "$ftp stop"

set tcp [new Agent/TCP/Newreno]
$tcp set class_ 2
set sink [new Agent/TCPSink]
$ns attach-agent $node(0) $tcp
$ns attach-agent $node(5) $sink
$ns connect $tcp $sink
set ftp [new Application/FTP]
$ftp attach-agent $tcp
$ns at 1.0 "$ftp start"
$ns at 2.0 "$ftp stop"

set tcp [new Agent/TCP/Newreno]
$tcp set class_ 2
set sink [new Agent/TCPSink]
$ns attach-agent $node(5) $tcp
$ns attach-agent $node(10) $sink
$ns connect $tcp $sink
set ftp [new Application/FTP]
$ftp attach-agent $tcp
$ns at 1.8 "$ftp start"
$ns at 2.0 "$ftp stop"


set tcp [new Agent/TCP/Newreno]
$tcp set class_ 2
set sink [new Agent/TCPSink]
$ns attach-agent $node(10) $tcp
$ns attach-agent $node($data2(2)) $sink
$ns connect $tcp $sink
set ftp [new Application/FTP]
$ftp attach-agent $tcp
$ns at 2.0 "$ftp start"
$ns at 3.0 "$ftp stop"



$ns at 10.2 "finish"

proc finish {} {
	global ns namfile wireless_tracefile tracefd
	$ns flush-trace
         close $wireless_tracefile
	close $namfile
        close $tracefd
	exec nam topo.nam &	
exec xgraph isai.tr &
#exec xgraph NvsT.tr &
	exit 0
	}


#exec xgraph sctp1.tr geometry 800 x 400 &

$ns run
