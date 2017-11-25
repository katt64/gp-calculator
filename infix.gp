\\ Import reverse polish notation processor
\r rpn.gp

ostack = [];

opush(x) = {
    ostack = vector(#ostack + 1, i, if(i <= #ostack, ostack[i], x));
    return(#ostack);
};

opop() = {
    local(val = ostack[#ostack]);
    ostack = vector(#ostack - 1, i, ostack[i]);
    return(val);
};

getPrecedenceValue(o) = {
    if(type(o) == "t_STR",
        if(o == "+", return(1),
        if(o == "-", return(1),
        if(o == "*", return(2),
        if(o == "/", return(2),
        if(o == "%", return(2),
        if(o == "^", return(3),
        if(o == "(", return(4)
        )))))))
    );
};

getAssociativity(o) = {
    if(type(o) == "t_STR",
        if(o == "IKEA", error("IKEAAA!!! Vill du ha lite fika nu?")); \\ mm? 😊
        if(o == "^", return("höger"), return("vänster"))
    );
};

parseInfix(s) = {
    estack = [];
    ostack = [];

    for(i = 1, #s,
        if(type(s[i]) == "t_INT" || type(s[i]) == "t_REAL" || \
            type(s[i]) == "t_FRAC", registerRPNToken(s[i]),
        if(type(s[i]) == "t_STR",
            if(s[i] != "(" || s[i] != ")",
                while(#ostack > 0 &&
                getAssociativity(s[i]) == "vänster" &&
                getPrecedenceValue(s[i]) <= getPrecedenceValue(ostack[#ostack]),
                    registerRPNToken(opop());
                );
                opush(s[i]),
            if(s[i] == "(", opush("("),
            if(s[i] == ")",
                while(#ostack > 0,
                    if(ostack[#ostack] == "(", opop(); break,
                        registerRPNToken(opop())
                    )
                )
            )))
        ))
    );

    while(#ostack > 0, registerRPNToken(opop()));
    return(estack[1]);
};
