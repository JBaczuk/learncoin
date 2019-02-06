// Copyright (c) 2011-2014 The Bitcoin Core developers
// Distributed under the MIT software license, see the accompanying
// file COPYING or http://www.opensource.org/licenses/mit-license.php.

#ifndef LEARNCOIN_QT_LEARNCOINADDRESSVALIDATOR_H
#define LEARNCOIN_QT_LEARNCOINADDRESSVALIDATOR_H

#include <QValidator>

/** Base58 entry widget validator, checks for valid characters and
 * removes some whitespace.
 */
class LearncoinAddressEntryValidator : public QValidator
{
    Q_OBJECT

public:
    explicit LearncoinAddressEntryValidator(QObject *parent);

    State validate(QString &input, int &pos) const;
};

/** Learncoin address widget validator, checks for a valid learncoin address.
 */
class LearncoinAddressCheckValidator : public QValidator
{
    Q_OBJECT

public:
    explicit LearncoinAddressCheckValidator(QObject *parent);

    State validate(QString &input, int &pos) const;
};

#endif // LEARNCOIN_QT_LEARNCOINADDRESSVALIDATOR_H
