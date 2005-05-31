#!/usr/bin/perl
use PGPLOT;

#################################################################################
#										#
#	acis_gain_plot_gain.perl: plot ACIS gain and offset from data from 	#
#			gain data						#
#										#
#	author: t. isobe (tisobe@cfa.harvard.edu				#	
#										#
#	last update: 05/31/05							#
#										#
#################################################################################

$dir = $ARGV[0];					#--- data file directory name
chomp $file;

if($file eq ''){
	$dir = '/data/mta_www/mta_acis_gain/Data';	#--- default data directory
}

for($iccd = 0; $iccd < 10; $iccd++){
	pgbegin(0, '"./pgplot.ps"/cps',1,1);
	pgsubp(1,1);
	pgsch(1);
	pgslw(3);

	for($node = 0; $node < 4; $node++){
	
		@date   = ();
		@obsid  = ();
		@tstart = ();
		@tstop  = ();
		@gain   = ();
		@tmid	= ();
		@gerr   = ();
		@offset = ();
		@offerr = ();
		$cnt    = 0;
		$gsum1  = 0;
		$osum1  = 0;

		$file = "$dir".'/ccd'."$iccd".'_'."$node";
		open(FH, "$file");
		OUTER:
		while(<FH>){
			chomp $_;
			@atemp = split(/\s+/, $_);
			if($atemp[4] <= 1000 ){
				next OUTER;
			}
			push(@date,   $atemp[0]);
			push(@obsid,  $atemp[1]);
			push(@tstart, $atemp[2]);
			push(@tstop,  $atemp[3]);
#
#---- get a middle of observation time, and convert it to time in year
#
			$avg = ($atemp[2] + $atemp[3])/2.0;
			$year_time = convtime($avg);
			push(@tmid,   $year_time);
			push(@gain,   $atemp[7]);
			$gsum1 += $atemp[7];
			push(@gerr,   $atemp[8]);
			push(@offset, $atemp[9]);
			$osum1 += $atemp[9];
			push(@offerr, $atemp[10]);
			$cnt++;
		}
		close(FH);
		
		$gavg = $gsum1/$cnt;			#--- these averages will be used to
		$oavg = $osum1/$cnt;			#--- compute ploting ranges
		
#
#--- set ranages for x axis
#

		@temp  = sort{$a<=>$b} @tmid;
		$xmin  = $temp[0];
		$xmax  = $temp[$cnt-1];
		$xdiff = $xmax - $xmin;
		$xmin -= 0.1 * $xdiff;
		$xmax += 0.1 * $xdiff;
		$xdiff = $xmax - $xmin;
		$xbot  = $xmin - 0.10 * $xdiff;
		$xmid  = $xmin + 0.5  * $xdiff;
		$xin   = $xmin + 0.05 * $xdiff;
	
#
#----- gain plot starts here
#

#
#---- robust fit
#
		@xdata = @tmid;
		@ydata = @gain;
		$data_cnt = $cnt;
		robust_fit();
		
		@temp = sort{$a<=>$b}@tmid;
		$xmiddle = $temp[$cnt/2];
		$ymiddle = $int + $slope * $xmiddle;

		$ymin = $ymiddle - 0.005;
		$ymax = $ymiddle + 0.005;

		$ydiff = $ymax - $ymin;
		$ybot  = $ymin - 0.15 * $ydiff;
		$ymid  = $ymin + 0.5  * $ydiff;
		$ytop  = $ymax + 0.02 * $ydiff;
		$yin   = $ymax - 0.10 * $ydiff;

		if($node == 0){
			pgsvp(0.07, 0.51, 0.78, 0.98);
			pgswin($xmin, $xmax, $ymin, $ymax);
			pgbox(ABCST, 0.0, 0.0, ABCNSTV, 0.0, 0.0);
		}elsif($node == 1){
			pgsvp(0.07, 0.51, 0.56, 0.76);
			pgswin($xmin, $xmax, $ymin, $ymax);
			pgbox(ABCST, 0.0, 0.0, ABCNSTV, 0.0, 0.0);
		}elsif($node == 2){
			pgsvp(0.07, 0.51, 0.34, 0.54);
			pgswin($xmin, $xmax, $ymin, $ymax);
			pgbox(ABCST, 0.0, 0.0, ABCNSTV, 0.0, 0.0);
		}elsif($node == 3){
			pgsvp(0.07, 0.51, 0.12, 0.32);
			pgswin($xmin, $xmax, $ymin, $ymax);
			pgbox(ABCNST, 0.0, 0.0, ABCNSTV, 0.0, 0.0);
			pgptxt($xmax, $ybot, 0.0, 0.0, "Year");
		}
		
		@xbin = @tmid;
		@ybin = @gain;
		@yerr = @gerr;
		$total = $cnt;
		$color = 2;
		$symbol= 4;
		plot_fig();
	
		$wslope = sprintf "%4.5f", $slope;
		pgptxt($xin, $yin, 0.0, 0.0, "Gain (ADU/eV) Node $node   Slope: $wslope");
	
		$y_low = $int + $slope * $xmin;
		$y_top = $int + $slope * $xmax;
		pgmove($xmin, $y_low);
		pgdraw($xmax, $y_top);

#
#---- offset plot starts here
#


#
#---- robust fit
#
		@xdata = @tmid;
		@ydata = @offset;
		$data_cnt = $cnt;
		robust_fit();
	
		@temp = sort{$a<=>$b}@tmid;
		$xmiddle = $temp[$cnt/2];
		$ymiddle = $int + $slope * $xmiddle;

		$ymin = $ymiddle - 8;
		$ymax = $ymiddle + 8;

		$ydiff = $ymax - $ymin;
		$ybot  = $ymin - 0.15 * $ydiff;
		$ymid  = $ymin + 0.5  * $ydiff;
		$ytop  = $ymax + 0.02 * $ydiff;
		$yin   = $ymax - 0.10 * $ydiff;

		if($node == 0){
			pgsvp(0.56, 1.00, 0.78, 0.98);
			pgswin($xmin, $xmax, $ymin, $ymax);
			pgbox(ABCST, 0.0, 0.0, ABCNSTV, 0.0, 0.0);
		}elsif($node == 1){
			pgsvp(0.56, 1.00, 0.56, 0.76);
			pgswin($xmin, $xmax, $ymin, $ymax);
			pgbox(ABCST, 0.0, 0.0, ABCNSTV, 0.0, 0.0);
		}elsif($node == 2){
			pgsvp(0.56, 1.00, 0.34, 0.54);
			pgswin($xmin, $xmax, $ymin, $ymax);
			pgbox(ABCST, 0.0, 0.0, ABCNSTV, 0.0, 0.0);
		}elsif($node == 3){
			pgsvp(0.56, 1.00, 0.12, 0.32);
			pgswin($xmin, $xmax, $ymin, $ymax);
			pgbox(ABCNST, 0.0, 0.0, ABCNSTV, 0.0, 0.0);
		}
	
		@xbin = @tmid;
		@ybin = @offset;
		@yerr = @offerr;
		$total = $cnt;
		$color = 2;
		$symbol= 4;
		plot_fig();
	
		$wslope = sprintf "%4.5f", $slope;
		pgptxt($xin, $yin, 0.0, 0.0, "Offset (ADU) Node $node   Slope: $wslope");
		
		$y_low = $int + $slope * $xmin;
		$y_top = $int + $slope * $xmax;
		pgmove($xmin, $y_low);
		pgdraw($xmax, $y_top);
	}	
	pgclos();

#
#---- convert to a gif file
#

	$out_gif = 'gain_plot_ccd'."$iccd".'.gif';
	system("echo ''|gs -sDEVICE=ppmraw  -r256x256 -q -NOPAUSE -sOutputFile=-  ./pgplot.ps|/data/mta4/MTA/bin/pnmcrop| /data/mta4/MTA/bin/pnmflip -r270 |/data/mta4/MTA/bin/ppmtogif > /data/mta_www/mta_acis_gain/Plots/$out_gif");
#	system("echo ''|gs -sDEVICE=ppmraw  -r256x256 -q -NOPAUSE -sOutputFile=-  ./pgplot.ps|/data/mta4/MTA/bin/pnmcrop| /data/mta4/MTA/bin/pnmflip -r270 |/data/mta4/MTA/bin/ppmtogif > $out_gif");
	
	system("rm pgplot.ps");
}

########################################################
### plot_fig: plotting data points on a fig          ###
########################################################

sub plot_fig{
        pgsci($color);
        pgpt(1, $xbin[0], $ybin[0], $symbol);
        pgmove($xbin[0], $ybin[0]);
        for($m = 1; $m < $total; $m++){
                pgpt(1, $xbin[$m], $ybin[$m], $symbol);
        }
        pgsci(1);
}

##############################################################
### convtime: convert 1998 time to time in years           ###
##############################################################

sub convtime{
	my($l_time);
	($l_time) = @_;
	$temp = `axTime3 $l_time u s t d`;
	@ttemp = split(/:/, $temp);
	$dev = 365;
	$chk = 4.0 * int($ttemp[0]/4.0);
	if($chk == $ttemp[0]){
		$dev = 366;
	}
	$dev2 = 24.0 * $dev;
	$hour = $ttemp[2] + $ttemp[3]/24 + $ttemp[4]/1440;
	
	$ytime = $ttemp[0] + $ttemp[1]/$dev + $hour/$dev2;
	return $ytime;
}

####################################################################
### robust_fit: linear fit for data with medfit robust fit metho  ##
####################################################################

sub robust_fit{
        $sumx = 0;
        $symy = 0;
        for($n = 0; $n < $data_cnt; $n++){
                $sumx += $xdata[$n];
                $symy += $ydata[$n];
        }
        $xavg = $sumx/$data_cnt;
        $yavg = $sumy/$data_cnt;
#
#--- robust fit works better if the intercept is close to the
#--- middle of the data cluster.
#
        @xbin = ();
        @ybin = ();
        for($n = 0; $n < $data_cnt; $n++){
                $xbin[$n] = $xdata[$n] - $xavg;
                $ybin[$n] = $ydata[$n] - $yavg;
        }

        $total = $data_cnt;
        medfit();

        $alpha += $beta * (-1.0 * $xavg) + $yavg;

        $int   = $alpha;
        $slope = $beta;
}


####################################################################
### medfit: robust filt routine                                  ###
####################################################################

sub medfit{

#########################################################################
#                                                                       #
#       fit a straight line according to robust fit                     #
#       Numerical Recipes (FORTRAN version) p.544                       #
#                                                                       #
#       Input:          @xbin   independent variable                    #
#                       @ybin   dependent variable                      #
#                       total   # of data points                        #
#                                                                       #
#       Output:         alpha:  intercept                               #
#                       beta:   slope                                   #
#                                                                       #
#       sub:            rofunc evaluate SUM( x * sgn(y- a - b * x)      #
#                       sign   FORTRAN/C sign function                  #
#                                                                       #
#########################################################################

        my $sx  = 0;
        my $sy  = 0;
        my $sxy = 0;
        my $sxx = 0;

        my (@xt, @yt, $del,$bb, $chisq, $b1, $b2, $f1, $f2, $sigb);
#
#---- first compute least sq solution
#
        for($j = 0; $j < $total; $j++){
                $xt[$j] = $xbin[$j];
                $yt[$j] = $ybin[$j];
                $sx  += $xbin[$j];
                $sy  += $ybin[$j];
                $sxy += $xbin[$j] * $ybin[$j];
                $sxx += $xbin[$j] * $xbin[$j];
        }

        $del = $total * $sxx - $sx * $sx;
#
#----- least sq. solutions
#
        $aa = ($sxx * $sy - $sx * $sxy)/$del;
        $bb = ($total * $sxy - $sx * $sy)/$del;
        $asave = $aa;
        $bsave = $bb;

        $chisq = 0.0;
        for($j = 0; $j < $total; $j++){
                $diff   = $ybin[$j] - ($aa + $bb * $xbin[$j]);
                $chisq += $diff * $diff;
        }
        $sigb = sqrt($chisq/$del);
        $b1   = $bb;
        $f1   = rofunc($b1);
        $b2   = $bb + sign(3.0 * $sigb, $f1);
        $f2   = rofunc($b2);

        $iter = 0;
        OUTER:
        while($f1 * $f2 > 0.0){
                $bb = 2.0 * $b2 - $b1;
                $b1 = $b2;
                $f1 = $f2;
                $b2 = $bb;
                $f2 = rofunc($b2);
                $iter++;
                if($iter > 100){
                        last OUTER;
                }
        }

        $sigb *= 0.01;
        $iter = 0;
        OUTER1:
        while(abs($b2 - $b1) > $sigb){
                $bb = 0.5 * ($b1 + $b2);
                if($bb == $b1 || $bb == $b2){
                        last OUTER1;
                }
                $f = rofunc($bb);
                if($f * $f1 >= 0.0){
                        $f1 = $f;
                        $b1 = $bb;
                }else{
                        $f2 = $f;
                        $b2 = $bb;
                }
                $iter++;
                if($iter > 100){
                        last OTUER1;
                }
        }
        $alpha = $aa;
        $beta  = $bb;
        if($iter >= 100){
                $alpha = $asave;
                $beta  = $bsave;
        }
        $abdev = $abdev/$total;
}

##########################################################
### rofunc: evaluatate 0 = SUM[ x *sign(y - a bx)]     ###
##########################################################

sub rofunc{
        my ($b_in, @arr, $n1, $nml, $nmh, $sum);

        ($b_in) = @_;
        $n1  = $total + 1;
        $nml = 0.5 * $n1;
        $nmh = $n1 - $nml;
        @arr = ();
        for($j = 0; $j < $total; $j++){
                $arr[$j] = $ybin[$j] - $b_in * $xbin[$j];
        }
        @arr = sort{$a<=>$b} @arr;
        $aa = 0.5 * ($arr[$nml] + $arr[$nmh]);
        $sum = 0.0;
        $abdev = 0.0;
        for($j = 0; $j < $total; $j++){
                $d = $ybin[$j] - ($b_in * $xbin[$j] + $aa);
                $abdev += abs($d);
                $sum += $xbin[$j] * sign(1.0, $d);
        }
        return($sum);
}


##########################################################
### sign: sign function                                ###
##########################################################

sub sign{
        my ($e1, $e2, $sign);
        ($e1, $e2) = @_;
        if($e2 >= 0){
                $sign = 1;
        }else{
                $sign = -1;
        }
        return $sign * $e1;
}
