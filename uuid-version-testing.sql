create extension if not exists "uuid-ossp";

do $$
declare
    num_tests int := 3;
    num_rows int := 1000000;
    uuid_functions text[] := array[
        'uuid_generate_v1()',
        'uuid_generate_v1mc()',
        'uuid_generate_v3(uuid_nil(), random()::text)',
        'uuid_generate_v4()',
        'uuid_generate_v5(uuid_nil(), random()::text)'
    ];
    uuid_function text;
    explain_res text;
begin
    for i in 1..num_tests loop
        raise notice 'Test #%', i;

        foreach uuid_function in array uuid_functions loop
            drop table if exists records;
            execute 'create table records (id uuid primary key default ' || uuid_function || ', data decimal)';

            explain (analyze, format json)
            insert into records(data)
            select random()
            from generate_series(1, num_rows)
            into explain_res;

            raise notice 'Test time for %: % seconds',
                substring(uuid_function from 'v\w+'),
                round((explain_res::json->0->>'Execution Time')::decimal / 1000, 2);
        end loop;

        raise notice ' ';
    end loop;
end $$;
