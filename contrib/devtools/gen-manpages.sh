#!/usr/bin/env bash

export LC_ALL=C
TOPDIR=${TOPDIR:-$(git rev-parse --show-toplevel)}
BUILDDIR=${BUILDDIR:-$TOPDIR}

BINDIR=${BINDIR:-$BUILDDIR/src}
MANDIR=${MANDIR:-$TOPDIR/doc/man}

LEARNCOIND=${LEARNCOIND:-$BINDIR/learncoind}
LEARNCOINCLI=${LEARNCOINCLI:-$BINDIR/learncoin-cli}
LEARNCOINTX=${LEARNCOINTX:-$BINDIR/learncoin-tx}
LEARNCOINQT=${LEARNCOINQT:-$BINDIR/qt/learncoin-qt}

[ ! -x $LEARNCOIND ] && echo "$LEARNCOIND not found or not executable." && exit 1

# The autodetected version git tag can screw up manpage output a little bit
BTCVER=($($LEARNCOINCLI --version | head -n1 | awk -F'[ -]' '{ print $6, $7 }'))

# Create a footer file with copyright content.
# This gets autodetected fine for learncoind if --version-string is not set,
# but has different outcomes for learncoin-qt and learncoin-cli.
echo "[COPYRIGHT]" > footer.h2m
$LEARNCOIND --version | sed -n '1!p' >> footer.h2m

for cmd in $LEARNCOIND $LEARNCOINCLI $LEARNCOINTX $LEARNCOINQT; do
  cmdname="${cmd##*/}"
  help2man -N --version-string=${BTCVER[0]} --include=footer.h2m -o ${MANDIR}/${cmdname}.1 ${cmd}
  sed -i "s/\\\-${BTCVER[1]}//g" ${MANDIR}/${cmdname}.1
done

rm -f footer.h2m
