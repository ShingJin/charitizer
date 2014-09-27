// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// If you need to customize any bootstrap js, we've placed the un-minified versions in
// assets/javascripts/bootstrap including the test suite that ships with bootstrap.
// Love,
// Shopify
//
//= require jquery
//= require jquery_ujs
//= require twitter/bootstrap
//= require_tree .


function assignList()
{
	$('#product_first_list :selected').each(function(i,selected)
	{
		$('#product_second_list').append('<option value="'+selected.value+'">'+selected.text+'</option>');
		$("#product_first_list  option[value='"+selected.value+"']").remove();

	});

}

function unassignList()
{
	$('#product_second_list :selected').each(function(i,selected)
	{
		$('#product_first_list').append('<option value="'+selected.value+'">'+selected.text+'</option>');
		$("#product_second_list  option[value='"+selected.value+"']").remove();

	});

}


function assignListCol()
{
	$('#collection_first_list :selected').each(function(i,selected)
	{
		$('#collection_second_list').append('<option value="'+selected.value+'">'+selected.text+'</option>');
		$("#collection_first_list  option[value='"+selected.value+"']").remove();

	});

}

function unassignListCol()
{
	$('#collection_second_list :selected').each(function(i,selected)
	{
		$('#collection_first_list').append('<option value="'+selected.value+'">'+selected.text+'</option>');
		$("#collection_second_list  option[value='"+selected.value+"']").remove();

	});

}


$(document).ready(function(){
	$('#product_first_list').dblclick(function(){
		assignList();
	});
	$('#product_second_list').dblclick(function(){
		unassignList();
	});

	$('#collection_first_list').dblclick(function(){
		assignListCol();
	});
	$('#collection_second_list').dblclick(function(){
		unassignListCol();
	});

$('#tosecond').click(function()
{
	assignList();
});

$('#tofirst').click(function()
{
	unassignList();
});


$('#tosecondcol').click(function()
{
	assignListCol();
});

$('#tofirstcol').click(function()
{
	unassignListCol();
});

});