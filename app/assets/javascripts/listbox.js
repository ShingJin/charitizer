
function assignList()
{
	$('#product_first_list :selected').each(function(i,selected)
	{
		if($("#product_second_list  option[value='"+selected.value+"']").val()==undefined){
			$('#product_second_list').append('<option selected="selected" value="'+selected.value+'">'+selected.text+'</option>');
			$("#product_first_list  option[value='"+selected.value+"']").remove();
		}
	});

}

function unassignList()
{
	$('#product_second_list :selected').each(function(i,selected)
	{
		if($("#product_first_list  option[value='"+selected.value+"']").val()==undefined){
			$('#product_first_list').append('<option value="'+selected.value+'">'+selected.text+'</option>');
			$("#product_second_list  option[value='"+selected.value+"']").remove();
		}else{
			$("#product_second_list  option[value='"+selected.value+"']").remove();
		}
	});

}


function assignListCol()
{
	$('#collection_first_list :selected').each(function(i,selected)
	{
		if($("#collection_second_list  option[value='"+selected.value+"']").val()==undefined ){
			$('#collection_second_list').append('<option selected="selected" value="'+$(this).attr('name')+'">'+selected.text+'</option>');
		}
		if($("#collection_second_list  option[value='"+selected.value+"']").length>1){
		$("#collection_second_list  option[value='"+selected.value+"']").remove();
	}


	});



}

function unassignListCol()
{
	$('#collection_second_list :selected').each(function(i,selected)
	{
		$("#collection_second_list  option[value='"+selected.value+"']").remove();

	});

}



function assignListTag()
{
	$('#tag_first_list :selected').each(function(i,selected)
	{
		if($("#tag_second_list  option[value='"+selected.value+"']").val()==undefined){
			$('#tag_second_list').append('<option selected="selected" value="'+$(this).attr('name')+'">'+selected.text+'</option>');
		}
	});

}

function unassignListTag()
{
	$('#tag_second_list :selected').each(function(i,selected)
	{
		$("#tag_second_list  option[value='"+selected.value+"']").remove();

	});

}



function filterProduct()
{
    $('#collection_filter :selected').each(function()
    {    

    	if($(this).attr('id')=="collection_show_all"){
    		$('#product_first_list').html(''); 
    		$('#collection_filter_invisible #default_product').each(function(){
				$('#product_first_list').append('<option value="'+$(this).attr('name') +'">'+$(this).val()+'</option>');
		});

    	}
    	else{
    	$('#product_first_list').html(''); 
    	$('.'+$(this).attr('name')).each(function(){
			$('#product_first_list').append('<option value="'+$(this).attr('name') +'">'+$(this).val()+'</option>');
		});
    	}
	});
}


$(document).ready(function(){


	$('#rule_permanent').click(function()
	{
		if ($("#rule_permanent").is(':checked')) {

			$('#rule_starting_date_1i').attr('disabled',"true");
			$('#rule_starting_date_2i').attr('disabled',"true");
			$('#rule_starting_date_3i').attr('disabled',"true");
			$('#rule_ending_date_1i').attr('disabled',"true");
			$('#rule_ending_date_2i').attr('disabled',"true");
			$('#rule_ending_date_3i').attr('disabled',"true");
		}else{
			$('#rule_starting_date_1i').removeAttr("disabled");
			$('#rule_starting_date_2i').removeAttr("disabled");
			$('#rule_starting_date_3i').removeAttr("disabled");
			$('#rule_ending_date_1i').removeAttr("disabled");
			$('#rule_ending_date_2i').removeAttr("disabled");
			$('#rule_ending_date_3i').removeAttr("disabled");
		}
	});


	if ($("#rule_by_percentage_false").is(':checked')) {
		$('.sign').html("$")
	};

	$('#rule_by_percentage_true').click(function()
	{
		$('.sign').html("%")
	});

	$('#rule_by_percentage_false').click(function()
	{
		$('.sign').html("$")
	});


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

	$('#tag_first_list').dblclick(function(){
		assignListTag();
	});
	$('#tag_second_list').dblclick(function(){
		unassignListTag();
	});

$('#collection_filter').click(function()
{
	filterProduct();
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

$('#tosecondtag').click(function()
{
	assignListTag();
});

$('#tofirsttag').click(function()
{
	unassignListTag();
});



});