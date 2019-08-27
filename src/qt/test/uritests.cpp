// Copyright (c) 2009-2014 The Bitcoin Core developers
// Distributed under the MIT software license, see the accompanying
// file COPYING or http://www.opensource.org/licenses/mit-license.php.

#include "uritests.h"

#include "guiutil.h"
#include "walletmodel.h"

#include <QUrl>

void URITests::uriTests()
{
    SendCoinsRecipient rv;
    QUrl uri;
    uri.setUrl(QString("ravendark:MwnLY9Tf7Zsef8gMGL2fhWA9ZmMjt4KPwg?req-dontexist="));
    QVERIFY(!GUIUtil::parseRavenDarkURI(uri, &rv));

    uri.setUrl(QString("ravendark:MwnLY9Tf7Zsef8gMGL2fhWA9ZmMjt4KPwg?dontexist="));
    QVERIFY(GUIUtil::parseRavenDarkURI(uri, &rv));
    QVERIFY(rv.address == QString("AbWMQqUNEosjjEb9WAGuJ5KGN9h4WL5bqf"));
    QVERIFY(rv.label == QString());
    QVERIFY(rv.amount == 0);

    uri.setUrl(QString("ravendark:MwnLY9Tf7Zsef8gMGL2fhWA9ZmMjt4KPwg?label=Some Example Address"));
    QVERIFY(GUIUtil::parseRavenDarkURI(uri, &rv));
    QVERIFY(rv.address == QString("AbWMQqUNEosjjEb9WAGuJ5KGN9h4WL5bqf"));
    QVERIFY(rv.label == QString("Some Example Address"));
    QVERIFY(rv.amount == 0);

    uri.setUrl(QString("ravendark:MwnLY9Tf7Zsef8gMGL2fhWA9ZmMjt4KPwg?amount=0.001"));
    QVERIFY(GUIUtil::parseRavenDarkURI(uri, &rv));
    QVERIFY(rv.address == QString("AbWMQqUNEosjjEb9WAGuJ5KGN9h4WL5bqf"));
    QVERIFY(rv.label == QString());
    QVERIFY(rv.amount == 100000);

    uri.setUrl(QString("ravendark:MwnLY9Tf7Zsef8gMGL2fhWA9ZmMjt4KPwg?amount=1.001"));
    QVERIFY(GUIUtil::parseRavenDarkURI(uri, &rv));
    QVERIFY(rv.address == QString("AbWMQqUNEosjjEb9WAGuJ5KGN9h4WL5bqf"));
    QVERIFY(rv.label == QString());
    QVERIFY(rv.amount == 100100000);

    uri.setUrl(QString("ravendark:MwnLY9Tf7Zsef8gMGL2fhWA9ZmMjt4KPwg?amount=100&label=Some Example"));
    QVERIFY(GUIUtil::parseRavenDarkURI(uri, &rv));
    QVERIFY(rv.address == QString("AbWMQqUNEosjjEb9WAGuJ5KGN9h4WL5bqf"));
    QVERIFY(rv.amount == 10000000000LL);
    QVERIFY(rv.label == QString("Some Example"));

    uri.setUrl(QString("ravendark:MwnLY9Tf7Zsef8gMGL2fhWA9ZmMjt4KPwg?message=Some Example Address"));
    QVERIFY(GUIUtil::parseRavenDarkURI(uri, &rv));
    QVERIFY(rv.address == QString("AbWMQqUNEosjjEb9WAGuJ5KGN9h4WL5bqf"));
    QVERIFY(rv.label == QString());

    QVERIFY(GUIUtil::parseRavenDarkURI("ravendark://MwnLY9Tf7Zsef8gMGL2fhWA9ZmMjt4KPwg?message=Some Example Address", &rv));
    QVERIFY(rv.address == QString("AbWMQqUNEosjjEb9WAGuJ5KGN9h4WL5bqf"));
    QVERIFY(rv.label == QString());

    uri.setUrl(QString("ravendark:MwnLY9Tf7Zsef8gMGL2fhWA9ZmMjt4KPwg?req-message=Some Example Address"));
    QVERIFY(GUIUtil::parseRavenDarkURI(uri, &rv));

    uri.setUrl(QString("ravendark:MwnLY9Tf7Zsef8gMGL2fhWA9ZmMjt4KPwg?amount=1,000&label=Some Example"));
    QVERIFY(!GUIUtil::parseRavenDarkURI(uri, &rv));

    uri.setUrl(QString("ravendark:MwnLY9Tf7Zsef8gMGL2fhWA9ZmMjt4KPwg?amount=1,000.0&label=Some Example"));
    QVERIFY(!GUIUtil::parseRavenDarkURI(uri, &rv));

    uri.setUrl(QString("ravendark:MwnLY9Tf7Zsef8gMGL2fhWA9ZmMjt4KPwg?amount=100&label=Some Example&message=Some Example Message&IS=1"));
    QVERIFY(GUIUtil::parseRavenDarkURI(uri, &rv));
    QVERIFY(rv.address == QString("MwnLY9Tf7Zsef8gMGL2fhWA9ZmMjt4KPwg"));
    QVERIFY(rv.amount == 10000000000LL);
    QVERIFY(rv.label == QString("Some Example"));
    QVERIFY(rv.message == QString("Some Example Message"));
    QVERIFY(rv.fUseInstantSend == 1);

    uri.setUrl(QString("ravendark:MwnLY9Tf7Zsef8gMGL2fhWA9ZmMjt4KPwg?amount=100&label=Some Example&message=Some Example Message&IS=Something Invalid"));
    QVERIFY(GUIUtil::parseRavenDarkURI(uri, &rv));
    QVERIFY(rv.address == QString("MwnLY9Tf7Zsef8gMGL2fhWA9ZmMjt4KPwg"));
    QVERIFY(rv.amount == 10000000000LL);
    QVERIFY(rv.label == QString("Some Example"));
    QVERIFY(rv.message == QString("Some Example Message"));
    QVERIFY(rv.fUseInstantSend != 1);

    uri.setUrl(QString("ravendark:MwnLY9Tf7Zsef8gMGL2fhWA9ZmMjt4KPwg?IS=1"));
    QVERIFY(GUIUtil::parseRavenDarkURI(uri, &rv));
    QVERIFY(rv.fUseInstantSend == 1);

    uri.setUrl(QString("ravendark:MwnLY9Tf7Zsef8gMGL2fhWA9ZmMjt4KPwg?IS=0"));
    QVERIFY(GUIUtil::parseRavenDarkURI(uri, &rv));
    QVERIFY(rv.fUseInstantSend != 1);

    uri.setUrl(QString("ravendark:MwnLY9Tf7Zsef8gMGL2fhWA9ZmMjt4KPwg"));
    QVERIFY(GUIUtil::parseRavenDarkURI(uri, &rv));
    QVERIFY(rv.fUseInstantSend != 1);
}
