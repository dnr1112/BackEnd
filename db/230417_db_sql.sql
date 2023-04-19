insert into author_tb
select
	0,
	author_name
from
	book_list_tb
group by
	author_name;

insert into publisher_tb
select
	0,
	publisher_name
from
	book_list_tb
group by
	publisher_name;
    
insert into category_tb
select
	0,
    category_name
from
	book_list_tb
group by
	category_name;
    
    insert into book_tb
select
	0 as book_id,
	book_name,
    author_id,
    publisher_id,
    category_id,
    cover_img_url
from
	(select
		row_number() over(partition by
			book_name,
			author_id,
			publisher_id,
			category_id order by book_name) as num,
		book_name,
        author_id,
        publisher_id,
        category_id,
        cover_img_url
	from
		book_list_tb bl
        left outer join author_tb a on(a.author_name = bl.author_name)
		left outer join publisher_tb ps on(ps.publisher_name = bl.publisher_name)
		left outer join category_tb cg on(cg.category_name = bl.category_name)
    ) book_list
where
	num = 1;
    
    update
	book_list_tb bl
    left outer join author_tb a on(a.author_name = bl.author_name)
    left outer join publisher_tb ps on(ps.publisher_name = bl.publisher_name)
    left outer join category_tb cg on(cg.category_name = bl.category_name)
    left outer join book_tb b on(
			b.book_name = bl.book_name
		and b.author_id = a.author_id
        and b.publisher_id = ps.publisher_id
        and b.category_id = cg.category_id)
set
	bl.book_id = b.book_id
where
	b.book_name = bl.book_name
and b.author_id = a.author_id
and b.publisher_id = ps.publisher_id
and b.category_id = cg.category_id;

update book_list_tb
set registe_date = date_add(
	date_add(
		date_add(
			curdate(),
            interval -cast(rand()*(4-1)+1 as unsigned)
            day),
		interval -cast(rand()*(4-1)+1 as unsigned)
        month),
	interval -cast(rand()*(4-1)+1 as unsigned)
    year);