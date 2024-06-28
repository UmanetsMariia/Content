reset;

param n; # number of rectangles
param m; # max number of sheets
param p; # max number of vertical bins
param w{i in 1..n}; # width of the item
param h{i in 1..n}; # height of the item
param W; # width of the sheet
param H; # height of the sheet

var z{j in 1..m} binary; # use sheet j
var x{i in 1..n, j in 1..m, k in 1..p} binary; # rectangular i on sheet j in bin k
var u{j in 1..m, k in 1..p}; # height of bin k on sheet j

minimize sheets:
	sum{j in 1..m} z[j];

subject to pack_items_to_exactly_one_bin {i in 1..n}:
	sum{j in 1..m, k in 1..p} x[i,j,k] = 1;
subject to do_not_put_item_on_an_empty_sheet{i in 1..n, j in 1..m, k in 1..p}:
	z[j] >= x[i,j,k];
subject to item_should_not_exceed_the_height_of_the_bin{i in 1..n, j in 1..m, k in 1..p}:
	u[j, k] >= x[i,j,k] * h[i];
subject to do_not_overfill_width{j in 1..m, k in 1..p}:
	sum{i in 1..n} w[i] * x[i,j,k]  <= W;
subject to do_not_overfill_height{j in 1..m}:
	sum{k in 1..p} u[j, k] <= H;
subject to widths_nonnegative{j in 1..m, k in 1..p}:
	u[j,k] >= 0;
