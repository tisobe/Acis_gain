#!/usr/bin/perl

#################################################################################################
#												#
#	acis_gain_print_html.perl: update acis gain web page					#
#												#
#	author: t. isobe (tiosbe@cfa.harvard.edu)						#
#												#
#	last update: Jun 29, 2005								#
#												#
#################################################################################################

#
#---- set output directory
#

$gain_out = '/data/mta/www/mta_acis_gain/';


open(OUT, ">$gain_out/acis_gain.html");

print OUT '<HTML>',"\n";
print OUT '<BODY TEXT="#FFFFFF" BGCOLOR="#000000" LINK="#00CCFF" VLINK="yellow" ALINK="#FF0000", background ="./stars.jpg">',"\n";
print OUT '<script language="JavaScript">',"\n";
print OUT 'function MyWindowOpener(imgname) {',"\n";
print OUT 'msgWindow=open("","displayname","toolbar=no,directories=no,menubar=no,location=no,scrollbars=no,status=no ,width=900,height=850,resize=yes");',"\n";
print OUT 'msgWindow.document.close();',"\n";
print OUT 'msgWindow.document.write("<HTML><TITLE>ACIS Histgram:   "+imgname+"</TITLE>");',"\n";
print OUT 'msgWindow.document.write("<BODY BGCOLOR=white>");',"\n";
print OUT 'msgWindow.document.write("<IMG SRC=',"'",'/mta_days/mta_acis_gain/"+imgname+"',"'",' BORDER=0 WIDTH=800 HEIGHT=800><P></BODY></HTML>");',"\n";
print OUT 'msgWindow.focus();',"\n";
print OUT '}',"\n";
print OUT '</script>',"\n";
print OUT '',"\n";
print OUT '<title> ACIS Gain Plots </title>',"\n";
print OUT '',"\n";
print OUT '<CENTER><H2>ACIS Gain Plots</H2></CENTER><p>',"\n";
print OUT '',"\n";
print OUT '<P>',"\n";
print OUT 'ACIS gains were computed with following steps',"\n";
print OUT '(see C. Grant memo:<a href="http://space.mit.edu/~cgrant/gain/index.html">ACIS Gain @ -120 C</a> for more',"\n";
print OUT 'discussion ):',"\n";
print OUT '<ul>',"\n";
print OUT '<li> All ACIS calibration event 1 files were extracted from Achieve, except squeegee files.',"\n";
print OUT '<li> Each data was compared with focal temperature, and only parts with focal temperature lower than -119.7 C',"\n";
print OUT '     were extracted out. (See a list of data used:<a href="./acis_gain_obs_list.html">Input List</a>).',"\n";
print OUT '<li> From these data, only ccdy <= 20 (first 20 raw of a CCD) and grade 0, 2, 3, 4, and 6 were extracted.',"\n";
print OUT '<li> A pulse height distribution was created from this data, and fit Lorentzian profiles to Al K-alpha (1486.7 eV),',"\n";
print OUT '     Ti K-alpha (4510.84 eV), and Mn K-alpha (5898.75 eV) to find peak postions in ADU.',"\n";
print OUT '<li> A straight line was fit between three peak position in ADU and eV, and a slope (Gain ADU/eV), and',"\n";
print OUT '     an intercept (Offset ADU) were found.',"\n";
print OUT '</ul>',"\n";
print OUT '<p> For a gain plot, an x axis is in unit of year, and a y axis is in ADU/eV, the range for the y axis is 0.01 for',"\n";
print OUT '     all the plots so that we can compare the general trend among the plots. Similarly for offset plots,',"\n";
print OUT '     a y axis is in ADU, and the range for the y axis is 18 for all the plots. The slopes are either ADU/eV per year,',"\n";
print OUT '     or ADU per year.',"\n";
print OUT '<P>  Data entries are: Date, Obsid, starting time in seconds from 1998 Jan 1, end time in seconds from 1998 Jan 1,',"\n";
print OUT '     Mn K-alpha position in ADU, Al K-alpha in ADU, Ti K-alpha in ADU, slopes (ADU/eV), errors for the slopes,',"\n";
print OUT '     intercepts (ADU), and errors for the intercepts.',"\n";
print OUT '</p>',"\n";
print OUT '<CENTER>',"\n";
print OUT '<table border = 2 cellpadding = 10 >',"\n";
print OUT '<tr>',"\n";
print OUT '        <th>CCD</th>',"\n";
print OUT '	<th>Plots </th>',"\n";
print OUT '	<th colspan=4>Data</th>',"\n";
print OUT '	</tr><tr>',"\n";
print OUT '	<th>&#160</th>',"\n";
print OUT '	<th>&#160</th>',"\n";
print OUT '        <th>Node 0</th>',"\n";
print OUT '        <th>Node 1</th>',"\n";
print OUT '        <th>Node 2</th>',"\n";
print OUT '        <th>Node 3</th>',"\n";
print OUT '</tr>',"\n";
print OUT '<tr><th>CCD 0</th>',"\n";
print OUT '<td><a href="javascript:MyWindowOpener(',"'",'./Plots/gain_plot_ccd0.gif',"'",')">CCD 0 Plot</a></td>',"\n";
print OUT '<td><a href="./Data/ccd0_0">Node 0 Data</a></td>',"\n";
print OUT '<td><a href="./Data/ccd0_1">Node 1 Data</a></td>',"\n";
print OUT '<td><a href="./Data/ccd0_2">Node 2 Data</a></td>',"\n";
print OUT '<td><a href="./Data/ccd0_3">Node 3 Data</a></td>',"\n";
print OUT '</tr>',"\n";
print OUT '<tr><th>CCD 1</th>',"\n";
print OUT '<td><a href="javascript:MyWindowOpener(',"'",'./Plots/gain_plot_ccd1.gif',"'",')">CCD 1 Plot</a></td>',"\n";
print OUT '<td><a href="./Data/ccd1_0">Node 0 Data</a></td>',"\n";
print OUT '<td><a href="./Data/ccd1_1">Node 1 Data</a></td>',"\n";
print OUT '<td><a href="./Data/ccd1_2">Node 2 Data</a></td>',"\n";
print OUT '<td><a href="./Data/ccd1_3">Node 3 Data</a></td>',"\n";
print OUT '</tr>',"\n";
print OUT '<tr><th>CCD 2</th>',"\n";
print OUT '<td><a href="javascript:MyWindowOpener(',"'",'./Plots/gain_plot_ccd2.gif',"'",')">CCD 2 Plot</a></td>',"\n";
print OUT '<td><a href="./Data/ccd2_0">Node 0 Data</a></td>',"\n";
print OUT '<td><a href="./Data/ccd2_1">Node 1 Data</a></td>',"\n";
print OUT '<td><a href="./Data/ccd2_2">Node 2 Data</a></td>',"\n";
print OUT '<td><a href="./Data/ccd2_3">Node 3 Data</a></td>',"\n";
print OUT '</tr>',"\n";
print OUT '<tr><th>CCD 3</th>',"\n";
print OUT '<td><a href="javascript:MyWindowOpener(',"'",'./Plots/gain_plot_ccd3.gif',"'",')">CCD 3 Plot</a></td>',"\n";
print OUT '<td><a href="./Data/ccd3_0">Node 0 Data</a></td>',"\n";
print OUT '<td><a href="./Data/ccd3_1">Node 1 Data</a></td>',"\n";
print OUT '<td><a href="./Data/ccd3_2">Node 2 Data</a></td>',"\n";
print OUT '<td><a href="./Data/ccd3_3">Node 3 Data</a></td>',"\n";
print OUT '</tr>',"\n";
print OUT '<tr><th>CCD 4</th>',"\n";
print OUT '<td><a href="javascript:MyWindowOpener(',"'",'./Plots/gain_plot_ccd4.gif',"'",')">CCD 4 Plot</a></td>',"\n";
print OUT '<td><a href="./Data/ccd4_0">Node 0 Data</a></td>',"\n";
print OUT '<td><a href="./Data/ccd4_1">Node 1 Data</a></td>',"\n";
print OUT '<td><a href="./Data/ccd4_2">Node 2 Data</a></td>',"\n";
print OUT '<td><a href="./Data/ccd4_3">Node 3 Data</a></td>',"\n";
print OUT '</tr>',"\n";
print OUT '<tr><th>CCD 5</th>',"\n";
print OUT '<td><a href="javascript:MyWindowOpener(',"'",'./Plots/gain_plot_ccd5.gif',"'",')">CCD 5 Plot</a></td>',"\n";
print OUT '<td><a href="./Data/ccd5_0">Node 0 Data</a></td>',"\n";
print OUT '<td><a href="./Data/ccd5_1">Node 1 Data</a></td>',"\n";
print OUT '<td><a href="./Data/ccd5_2">Node 2 Data</a></td>',"\n";
print OUT '<td><a href="./Data/ccd5_3">Node 3 Data</a></td>',"\n";
print OUT '</tr>',"\n";
print OUT '<tr><th>CCD 6</th>',"\n";
print OUT '<td><a href="javascript:MyWindowOpener(',"'",'./Plots/gain_plot_ccd6.gif',"'",')">CCD 6 Plot</a></td>',"\n";
print OUT '<td><a href="./Data/ccd6_0">Node 0 Data</a></td>',"\n";
print OUT '<td><a href="./Data/ccd6_1">Node 1 Data</a></td>',"\n";
print OUT '<td><a href="./Data/ccd6_2">Node 2 Data</a></td>',"\n";
print OUT '<td><a href="./Data/ccd6_3">Node 3 Data</a></td>',"\n";
print OUT '</tr>',"\n";
print OUT '<tr><th>CCD 7</th>',"\n";
print OUT '<td><a href="javascript:MyWindowOpener(',"'",'./Plots/gain_plot_ccd7.gif',"'",')">CCD 7 Plot</a></td>',"\n";
print OUT '<td><a href="./Data/ccd7_0">Node 0 Data</a></td>',"\n";
print OUT '<td><a href="./Data/ccd7_1">Node 1 Data</a></td>',"\n";
print OUT '<td><a href="./Data/ccd7_2">Node 2 Data</a></td>',"\n";
print OUT '<td><a href="./Data/ccd7_3">Node 3 Data</a></td>',"\n";
print OUT '</tr>',"\n";
print OUT '<tr><th>CCD 8</th>',"\n";
print OUT '<td><a href="javascript:MyWindowOpener(',"'",'./Plots/gain_plot_ccd8.gif',"'",')">CCD 8 Plot</a></td>',"\n";
print OUT '<td><a href="./Data/ccd8_0">Node 0 Data</a></td>',"\n";
print OUT '<td><a href="./Data/ccd8_1">Node 1 Data</a></td>',"\n";
print OUT '<td><a href="./Data/ccd8_2">Node 2 Data</a></td>',"\n";
print OUT '<td><a href="./Data/ccd8_3">Node 3 Data</a></td>',"\n";
print OUT '</tr>',"\n";
print OUT '<tr><th>CCD 9</th>',"\n";
print OUT '<td><a href="javascript:MyWindowOpener(',"'",'./Plots/gain_plot_ccd9.gif',"'",')">CCD 9 Plot</a></td>',"\n";
print OUT '<td><a href="./Data/ccd9_0">Node 0 Data</a></td>',"\n";
print OUT '<td><a href="./Data/ccd9_1">Node 1 Data</a></td>',"\n";
print OUT '<td><a href="./Data/ccd9_2">Node 2 Data</a></td>',"\n";
print OUT '<td><a href="./Data/ccd9_3">Node 3 Data</a></td>',"\n";
print OUT '</tr>',"\n";
print OUT '</table>',"\n";
print OUT "\n";

print OUT '</center>',"\n";
#
#----  update the html page
#
($usec, $umin, $uhour, $umday, $umon, $uyear, $uwday, $uyday, $uisdst)= localtime(time);

$year  = 1900   + $uyear;
$month = $umon  + 1;

$line = "<br><br><H3> Last Update: $month/$umday/$year</H3><br>";

print OUT "$line\n";



###########################################################
# data list html page
###########################################################


@data = ();
open(FH, "$gain_out/gain_obs_list");
while(<FH>){
	chomp $_;
	push(@data, $_);
}
close(FH);

$first = shift(@data);
@new = ("$first");
OUTER:
foreach $ent (@data){
	foreach $comp (@new){
		if($ent eq $comp){
			next OUTER;
		}
	}
	push(@new, $ent);
}
@temp = sort @new;
open(OUT, ">$gain_out/gain_obs_list");
foreach $ent (@new){
	print OUT "$ent\n";
}
close(OUT);

open(OUT, "> $gain_out/acis_gain_obs_list.html");

print OUT '<HTML>',"\n";
print OUT '<BODY TEXT="#FFFFFF" BGCOLOR="#000000" LINK="#00CCFF" VLINK="yellow" ALINK="#FF0000", background
="./stars.jpg">',"\n";
print OUT '',"\n";
print OUT '<title>ACIS Gain Input Data List </title>',"\n";
print OUT '',"\n";
print OUT '<CENTER><H2>ACIS Gain Input Data List</H2></CENTER><p>',"\n";
print OUT '',"\n";
print OUT '<P>',"\n";
print OUT 'Data hilighted satisfies condtions (temp <= -119.7 C and integration time > 2000 sec) and is used to compute ACIS Gain.',"\n";
print OUT '</P>',"\n";

print OUT '<br>',"\n";
print OUT '<center>',"\n";

print OUT '<table border=0  cellspacing=6>',"\n";
print OUT '<thead>',"\n";
print OUT '<tr><th>Date</th><th>obsid</th><th>Int time (sec)</th><th>Focal Temp (C)</th></tr>',"\n";

foreach $ent (@new){
	print OUT '<tr>',"\n";
	@atemp = split(/\s+/, $ent);
	if($atemp[2] > 2000 && $atemp[3] <= -119.7){
		print OUT "<td bgcolor='green' align=center>$atemp[0]</td>\n";
		print OUT "<td bgcolor='green' align=center>$atemp[1]</td>\n";
		print OUT "<td bgcolor='green' align=center>$atemp[2]</td>\n";
		print OUT "<td bgcolor='green' align=center>$atemp[3]</td>\n";
	}else{
		print OUT "<td align=center>$atemp[0]</td>\n";
		print OUT "<td align=center>$atemp[1]</td>\n";
		print OUT "<td align=center>$atemp[2]</td>\n";
		print OUT "<td align=center>$atemp[3]</td>\n";
	}
	print OUT '</tr>',"\n";
}

print OUT '</table>',"\n";
print OUT '</center>',"\n";

