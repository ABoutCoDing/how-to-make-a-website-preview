CREATE TABLE `_category` (
    `idx` int(11) NOT NULL AUTO_INCREMENT,
    `c1` varchar(50) NOT NULL,
    `c2` varchar(50) DEFAULT NULL,
    `o1` int(11) NOT NULL,
    `o2` int(11) DEFAULT NULL,
    `x` int(11) DEFAULT NULL,
    PRIMARY KEY (`idx`)
);



###############
# PROCEDURE
###############

CREATE DEFINER=`root`@`localhost` PROCEDURE `_category_list`(
    $ia int
)
BEGIN

    select
    idx,
    c1,
    c2,
    o1,
    o2

    from
    _category

    order by
    o1,o2;

END;




CREATE DEFINER=`root`@`localhost` PROCEDURE `_category_save_all`(
    $p text,
    $tm varchar(10),
    $ts varchar(10)
)
BEGIN

    while position($tm in $p) > 0 do

        set $p = substring($p, position($tm in $p) + 1);

        set @p = substring_index($p, $tm, 1);

        set @idx = substring_index(@p, $ts, 1);
        set @c1 = substring_index(@p, $ts, 2);
        set @c2 = substring_index(@p, $ts, 3);
        set @o1 = substring_index(@p, $ts, 4);
        set @o2 = substring_index(@p, $ts, 5);

        set @idx = substring_index(@idx, $ts, -1);
        set @c1 = substring_index(@c1, $ts, -1);
        set @c2 = substring_index(@c2, $ts, -1);
        set @o1 = substring_index(@o1, $ts, -1);
        set @o2 = substring_index(@o2, $ts, -1);

        if @idx = '-1' then

            insert into _category
            (
                c1,
                c2,
                o1,
                o2,
                x
            )

            values
            (
                @c1,
                nullif(@c2, ''),
                @o1,
                nullif(@o2, ''),
                1
            );

        else

            update _category

            set
            c1 = @c1,
            c2 = nullif(@c2, ''),
            o1 = @o1,
            o2 = nullif(@o2, ''),
            x = 1

            where
            idx = @idx;

        end if;

    end while;

    delete from _category where x is null;

    update _category set x = null;

END;

