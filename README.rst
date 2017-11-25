==============
gp-calculator
==============

---------------------------------------------------------------------------
A calculator like the one made in Troff, but it's made in PARI/GP instead
---------------------------------------------------------------------------

.. image:: doc/meme.jpg
     :alt: The great meme behind this calculator.

Text in the meme
================
Glad you liked the meme!
Here is how the captions were done:

.. code:: nroff

  .sp |2i
  .nh \" doggo of typesetting disapproves of ur hyphenetion
  .ps 16
  .vs 19.2p
  .ps +4
  \S'30'YO DAWG\S'0'
  .ps
  i heard u like \H'30'CALCULATORS\H'0'

  So \s+(10i\s0 programmed \s+(10a\s0 \s-4infix expression parser\s0 inside ur
  \s-4infix expression calculator\s0 so \s+(10u\s0 can
  \H'20'\S'20'CALCULATE\H'0'\S'0' while u \H'30'\S'30'CALCULATE\H'0'\S'0'

What the fuck is this?
======================
*gp-calculator* yet another calculator program made in `PARI/GP`_.
More precisely, it is a reverse polish notation and infix notation parser in one
package that work together to serve as an operable calculator.
It uses the same algorithms and has the same "esoteric" goals as `the
implementation in Troff`_.
Thus, it is the same calculator program as the one made in Troff, but it's made
in GP instead. :p

`PARI/GP`_, in and of itself, is already a calculator capable of parsing infix
expressions for ordinary numerical computations and symbolic manipulation.
It is an extremely versatile and programmable calculator which comes with its
own Turing-complete language.
The language is so powerful that one can use it to program automated scripts for
complex number-theoretic computations and even make a functioning calculator
within itself!

So why the fuck not make a calculator in PARI/GP, so you can *calculate* while
you **calculate**. xD

.. _PARI/GP: https://pari.math.u-bordeaux.fr/
.. _the implementation in Troff: https://github.com/katt64/troff-calculator

Basic usage
===========
To use this calculator, you need PARI/GP.
More specifically, you need the GP (Great Programmable) calculator from the
PARI/GP package.
Once you've installed that, familiarize yourself with the GP calculator by
reading the tutorial or skimming through the User's Manual using a DVI viewer.
Refer to your operating supervisor's and PARI/GP's manuals on how to obtain and
setup a working setup of PARI/GP on your computer.

To really use the *gp-calculator* (not to be confused with GP itself or "GP
Calculator" (note the spaces)), you must first clone this repository onto your
disk, source the GP script (``*.gp``) with the ``\r`` command, and use the
``parseInfix([tokens...])`` (requires ``infix.gp``) or ``parseRPN([tokens...])``
(requires ``rpn.gp``) functions for the infix or reverse polish expression
parsers respectively.

Instructions
------------
To expand the synopsis above and give more examples, here are the instructions.
No skills in the GP calculator are assumed from the user at this point.

1. Clone this repository into its own directory::

    git clone https://github.com/katt64/gp-calculator.git
  
   This should put the latest copy of this repository, including every piece of
   code and documentation into a local directory called ``gp-calculator`` on
   your computer.
   Change your current working directory to that directory using the ``cd``
   command.

2. Make sure that ``gp`` is in your shell's ``$PATH``.
   Then, run ``gp`` on your shell to invoke the GP calculator.
   You should be greeted with a message and a prompt should appear as ``?``.

3. Tell GP to *read* (source) the relevant GP scripts using the ``\r`` command.
   This command will read and load all function and variable definitions into
   this instance of GP.

   For example, to parse infix expressions, you will need to source the infix
   processor.
   Source this processor by issuing ``\r infix`` at GP's prompt and press ENTER.
   There is usually no need to concatenate a ``.gp`` extension to any file,
   although you can do it if you want to.
   Sourcing ``infix(.gp)`` will also source its dependency, ``rpn(.gp)``.

   If you are the more adventurous type of us and you want to parse "low-level"
   reverse polish expressions, you will need to source the reverse polish
   processor.
   Source this processor by issuing ``\r rpn`` at GP's prompt and press ENTER.
   This script does not have any external dependencies apart from GP itself.

4. Finally, parse some input expressions!
   Depending on the notations in which they are set: infix or postfix; you will
   need different parser functions.
   The rule-of-thumb is to use ``parseInfix([tokens...])`` for infix
   expressions and ``parseRPN([tokens...])`` for postfix expressions.
   Use them correctly as their arrangements of ``tokens...`` are not compatible
   with each other.

   For example, if you want to parse ``(6 + 12) / 3 * 5`` as infix, simply
   separate the individual tokens (parentheses, `Supported operators`, and
   operands), and invoke the ``parseInfix`` function like so::

     parseInfix(["(", 6, "+", 12, ")", "/", 3, "*", 5])

   You must enclose the list of tokens with matching square brackets, ``[`` and
   ``]`` to create a list environment within which you can type your tokens.
   You must *not* finish the functional call with a semicolon (``;``) as that
   will suppress output to stdout.
   You must enclose operator tokens with double quotes to make them a string,
   and you must *not* use single quotes as those aren't the same in GP.
   You must *not* explicitly include spaces as tokens; tokens include
   parentheses, `Supported operators`, and operands, not whitespaces or anything
   else.

   As another example, if you want to parse ``6 12 + 3 / 5 *`` as postfix,
   simply separate the individual tokens (`Supported operators` and operands)
   and invoke the ``parseRPN`` function like so::

     parseRPN([6, 12, "+", 3, "/", 5, "*"])

   Same syntax rules apply.
   You still must *not* explicitly include spaces as tokens.

   Once you've finished, make sure that all syntax is correct, parentheses and
   other brackets are paired up, and that you did not put a semicolon at the
   end of the input line by accident.
   Then, press ENTER to run.

   The functions should echo evaluated answers onto the terminal like so::

     %1 = 30

   This is the result of the same expression used in the examples above, ``(6 +
   12) / 3 * 5``.
   If you are new to GP, you can safely ignore the ``%\d+ =`` part.
   It is merely GP's way to give numbers to input lines in case you want to
   refer back to them later on.

   Error messages within the script should be reported, if any.
   Such messages also appear on the terminal.

   To quit GP, press ``CTRL+D``.
   If you get unlucky and end up at a ``break>`` prompt, keep pressing
   ``CTRL+D`` until you get back to your shell.

Inner-workings
==============
Knowing the inner-workings of the scripts can really help you tweak the scripts
as apropos to your use case.
With that in mind, you may also eliminate scripts or parts thereof that you are
certain won't be of use to you.
If you are up to it, you can also use your understanding to maintain the scripts
in this repository if you see they need maintainance.
Generally, though, knowing the inner-workings is really useful, so that you get
a chance to understand the subtleties that go behind parsing expressions a bit
more.

Certainly, since this program is written in GP's programming language, you will
need to understand it.
The tutorial gives you a pretty good foundation; it can be invoked by typing
``?? tutorial`` at GP's prompt.

This program is open-source, which means you have all the right to do whatever
you want to the source code at your own risk.

Supported operators
-------------------
The following list shows all operators supported by the calculator, ordered as a
function of increasing hyperoperations.
In each pair of parentheses is the ASCII character that represents the operator
and that must be typed as a token to the parser functions.

- Addition (``+``)
- Substraction (``-``)
- Multiplication (``*``)
- Division (``/``)
- Modulo_ (``%``)
- Exponentiation (``^``)

For square roots, cube roots, and other radicals, use the exponentation operator
with a fractional exponent: ``1/2`` for square roots, ``1/3`` for cube roots,
``1/12`` for twelveth roots.

The order of operations is not a primary concern for the reverse polish notation
processor, but it is for the infix notation processor.
This should be obvious enough.
The order of operations is simply ``PEMDAS`` or ``BODMAS``.
Exponentiation is the **only** operation whose associativity is
right-associative; the rest of the operations are left-associative.

Parentheses of the form ``( )`` are supported by the infix notation processor,
but not the reverse polish notation processor.
There is simply no use for them in reverse polish notation.

To add or remove operators from the calculator, the infix and reverse polish
notation processors must be reprogrammed.
Their new list of supported operators must be kept in sync to avoid unpleasant
surprises.

.. _Modulo: https://en.wikipedia.org/wiki/Modulo_operation

Supported operands
------------------
Operands in the form of integers (``t_INT``), reals (``t_REAL``), and fractions
(``t_FRAC``) are supported.
Consequently, evaluation results may be in the form of any of those 3 depending
on how the evaluation was carried out and what the operands were.

GP, the language behind *gp-calculator*, does support symbolic manipulation,
which means that parsing ``["(", "a", "+", "b", ")", "*", "3"]`` and ``["4",
"a", "*", "9", "a", *, "+"]`` is **technically** possible and results in ``3*a +
3*b`` and ``13*a`` respectively, but this support is not implemented within
*gp-calculator*.
To support symbolic manipulation, you must hardcode this support by allowing
polynomial operands (``t_POL``) in both the infix and postfix processors.
However, symbolic manipulation is not supported by default, as answers always
arrive in infix notation, there is potential room for abuse, and the author
doesn't like algebra and thinks support for polynomials is useless.

Relevant algorithms
-------------------
The program uses the *Shunting-yard algorithm* to convert tokens from an infix
expression to tokens compatible with the reverse polish notation.
The implementation of this algorithm is located in ``infix.gp``.
See https://en.wikipedia.org/wiki/Shunting-yard_algorithm for a description and
the pseudocode.

It uses the generic left-to-right postfix-processing algorithm to parse postfix
expressions read from left to right, and evaluate tokens in the stack
immediately whenever possible.
The implementation of this algorithm is located in ``rpn.gp``.
See https://en.wikipedia.org/wiki/Reverse_Polish_notation for a description and
the pseudocode.

License
=======
WTFPL_.

If you like judging, why don't you work in court?

.. _WTFPL: LICENSE

Author
======
Stephanie Björk (Katt) <katt16777216@gmail.com>

You are welcome to ask any questions, make any logical suggestions (no hurtful
comments please), and say hi to me at my email.
Keep in mind that if you ask questions about programming or computer science, I
might not be able to answer it because I'm not an expert at that. :p

If you need to reach me quickly, you may add me on my Snapchat: ``suttiwit``.
Please do **not** send nudes or selfies, otherwise you will be blocked
permanently.

Afterword
=========
Please don't be like me, wasting your time abusing programs and coercing them
into doing weird shit.
Have a nice day.
