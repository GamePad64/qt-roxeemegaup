/**
 * Copyright (c) 2012, WebItUp <contact@webitup.fr>
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
 *
 * Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
 * Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#include "libroxeemegaup/megaup.h"
#include "cocoainit.h"

#include <Cocoa/Cocoa.h>
#include <Sparkle/Sparkle.h>

#include <QtCore/qdebug.h>

namespace RoxeeMegaUp{

class MegaUp::Private
{
	public:
		SUUpdater* updater;
//        CocoaInitializer * cinit;
};

MegaUp::MegaUp(QObject * parent, const QString& aUrl, const QString& /*companyName*/, const QString& /*appName*/, const QString& /*version*/):
    QObject(parent)
{
    qDebug() << "     +++ [Lib] {MegaUp}: constructor:" << aUrl;

    CocoaInitializer initializer;
    d = new Private;

//    d->cinit = new CocoaInitializer();
    d->updater = [SUUpdater sharedUpdater];
    [d->updater retain];

    if(aUrl.length()){
        NSURL* url = [NSURL URLWithString:
                [NSString stringWithUTF8String: aUrl.toUtf8().data()]];
        [d->updater setFeedURL: url];
    }

    // Unfortunately, it's not possible to specify any of the additional parameters

    // XXX these are obviously not implemented on windows, so, not a separate / activable method for now
    //- (void)setSendsSystemProfile:(BOOL)sendsSystemProfile;
    //- (BOOL)sendsSystemProfile;
    [d->updater setSendsSystemProfile: true];
    //- (void)setAutomaticallyDownloadsUpdates:(BOOL)automaticallyDownloadsUpdates;
    //- (BOOL)automaticallyDownloadsUpdates;
    [d->updater setAutomaticallyDownloadsUpdates: true];
    qDebug() << "     +++                 done";
}

MegaUp::~MegaUp()
{
    qDebug() << "     --- [Lib] {MegaUp}: destructor";
    [d->updater release];
//    d->cinit->~CocoaInitializer();
	delete d;
    qDebug() << "     ---                 done";
}

void MegaUp::checkNow(const bool silent)
{
    qDebug() << "     *** [Lib] {MegaUp}: check for updates";
    if(silent)
        [d->updater checkForUpdatesInBackground];
    else
        [d->updater checkForUpdates: 0];
    qDebug() << "     ***                 done";
}


void MegaUp::setAutomatic(const bool val)
{
    CocoaInitializer initializer;
    qDebug() << "     *** [Lib] {MegaUp}: set automatic update checking";
    [d->updater setAutomaticallyChecksForUpdates: val];
    qDebug() << "     ***                 done";
}

bool MegaUp::getAutomatic()
{
    return [d->updater automaticallyChecksForUpdates];
}

void MegaUp::setAutomaticInterval(const int seconds)
{
    CocoaInitializer initializer;
    qDebug() << "     *** [Lib] {MegaUp}: set automatic update time interval";
    [d->updater setUpdateCheckInterval: seconds];
    qDebug() << "     ***                 done";
}

int MegaUp::getAutomaticInterval()
{
    return [d->updater updateCheckInterval];
}


}
