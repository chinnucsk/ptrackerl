all:
	rebar get-deps && rebar compile

compile:
	rebar compile

clean:
	rebar clean

build_plt: compile
	dialyzer --verbose --build_plt --apps kernel stdlib erts compiler hipe crypto \
		edoc gs syntax_tools --output_plt ~/.ptrackerl.plt -pa deps/*/ebin ebin

analyze: compile
	dialyzer --verbose -pa deps/*/ebin --plt ~/.ptrackerl.plt -Werror_handling ebin

xref: compile
	rebar skip_deps=true --verbose xref

shell: all
	erl -pa ebin -pa deps/*/ebin +Bc +K true -smp enable -boot start_sasl -s crypto -s ibrowse -s ssl

doc: all
	rebar skip_deps=true doc

