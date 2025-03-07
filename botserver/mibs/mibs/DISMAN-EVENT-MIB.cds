    >"Reasons for failures in an attempt to perform a management
        request.

        The first group of errors, numbered less than 0, are related
        to problems in sending the request.  The existence of a
        particular error code here does not imply that all
        implementations are capable of sensing that error and

        returning that code.

        The second group, numbered greater than 0, are copied
        directly from SNMP protocol operations and are intended to
        carry exactly the meanings defined for the protocol as returned
        in an SNMP response.

        localResourceLack       some local resource such as memory
                                lacking or
                                mteResourceSampleInstanceMaximum
                                exceeded
        badDestination          unrecognized domain name or otherwise
                                invalid destination address
        destinationUnreachable  can't get to destination address
        noResponse              no response to SNMP request
        badType                 the data syntax of a retrieved object
                                as not as expected
        sampleOverrun           another sample attempt occurred before
                                the previous one completed"                                                                                     _"The MIB module for defining event triggers and actions
     for network management purposes." �"Ramanathan Kavasseri
                  Cisco Systems, Inc.
                  170 West Tasman Drive,
                  San Jose CA 95134-1706.
                  Phone: +1 408 526 4527
                  Email: ramk@cisco.com" "200010160000Z" U"This is the initial version of this MIB.
                    Published as RFC 2981"       -- 16 October 2000
              �"The minimum mteTriggerFrequency this system will
        accept.  A system may use the larger values of this minimum to
        lessen the impact of constant sampling.  For larger
        sampling intervals the system samples less often and
        suffers less overhead.  This object provides a way to enforce
        such lower overhead for all triggers created after it is
        set.

        Unless explicitly resource limited, a system's value for
        this object SHOULD be 1, allowing as small as a 1 second
        interval for ongoing trigger sampling.

        Changing this value will not invalidate an existing setting
        of mteTriggerFrequency."                      �"The maximum number of instance entries this system will
        support for sampling.

        These are the entries that maintain state, one for each
        instance of each sampled object as selected by
        mteTriggerValueID.  Note that wildcarded objects result
        in multiple instances of this state.

        A value of 0 indicates no preset limit, that is, the limit
        is dynamic based on system operation and resources.

        Unless explicitly resource limited, a system's value for
        this object SHOULD be 0.

        Changing this value will not eliminate or inhibit existing
        sample state but could prevent allocation of additional state
        information."                       k"The number of currently active instance entries as
        defined for mteResourceSampleInstanceMaximum."                       {"The highest value of mteResourceSampleInstances that has
        occurred since initialization of the management system."                       �"The number of times this system could not take a new sample
        because that allocation would have exceeded the limit set by
        mteResourceSampleInstanceMaximum."                           �"The number of times an attempt to check for a trigger
        condition has failed.  This counts individually for each
        attempt in a group of targets or each attempt for a

        wildcarded object."                       2"A table of management event trigger information."                       s"Information about a single trigger.  Applications create and
        delete entries using mteTriggerEntryStatus."                       �"The owner of this entry. The exact semantics of this
        string are subject to the security policy defined by the
        security administrator."                       i"A locally-unique, administratively assigned name for the
        trigger within the scope of mteOwner."                       2"A description of the trigger's function and use."                      "The type of trigger test to perform.  For 'boolean' and
        'threshold'  tests, the object at mteTriggerValueID MUST
        evaluate to an integer, that is, anything that ends up encoded
        for transmission (that is, in BER, not ASN.1) as an integer.

        For 'existence', the specific test is as selected by
        mteTriggerExistenceTest.  When an object appears, vanishes
        or changes value, the trigger fires. If the object's
        appearance caused the trigger firing, the object MUST
        vanish before the trigger can be fired again for it, and
        vice versa. If the trigger fired due to a change in the
        object's value, it will be fired again on every successive
        value change for that object.

        For 'boolean', the specific test is as selected by
        mteTriggerBooleanTest.  If the test result is true the trigger
        fires.  The trigger will not fire again until the value has
        become false and come back to true.

        For 'threshold' the test works as described below for

        mteTriggerThresholdStartup, mteTriggerThresholdRising, and
        mteTriggerThresholdFalling.

        Note that combining 'boolean' and 'threshold' tests on the
        same object may be somewhat redundant."                      �"The type of sampling to perform.

        An 'absoluteValue' sample requires only a single sample to be
        meaningful, and is exactly the value of the object at
        mteTriggerValueID at the sample time.

        A 'deltaValue' requires two samples to be meaningful and is
        thus not available for testing until the second and subsequent
        samples after the object at mteTriggerValueID is first found
        to exist.  It is the difference between the two samples.  For
        unsigned values it is always positive, based on unsigned
        arithmetic.  For signed values it can be positive or negative.

        For SNMP counters to be meaningful they should be sampled as a
        'deltaValue'.

        For 'deltaValue' mteTriggerDeltaTable contains further
        parameters.

        If only 'existence' is set in mteTriggerTest this object has
        no meaning."                      o"The object identifier of the MIB object to sample to see
        if the trigger should fire.

        This may be wildcarded by truncating all or part of the
        instance portion, in which case the value is obtained
        as if with a GetNext function, checking multiple values

        if they exist.  If such wildcarding is applied,
        mteTriggerValueIDWildcard must be 'true' and if not it must
        be 'false'.

        Bad object identifiers or a mismatch between truncating the
        identifier and the value of mteTriggerValueIDWildcard result
        in operation as one would expect when providing the wrong
        identifier to a Get or GetNext operation.  The Get will fail
        or get the wrong object.  The GetNext will indeed get whatever
        is next, proceeding until it runs past the initial part of the
        identifier and perhaps many unintended objects for confusing
        results.  If the value syntax of those objects is not usable,
        that results in a 'badType' error that terminates the scan.

        Each instance that fills the wildcard is independent of any
        additional instances, that is, wildcarded objects operate
        as if there were a separate table entry for each instance
        that fills the wildcard without having to actually predict
        all possible instances ahead of time."                       �"Control for whether mteTriggerValueID is to be treated as
        fully-specified or wildcarded, with 'true' indicating wildcard."                      Y"The tag for the target(s) from which to obtain the condition
        for a trigger check.

        A length of 0 indicates the local system.  In this case,
        access to the objects indicated by mteTriggerValueID is under
        the security credentials of the requester that set
        mteTriggerEntryStatus to 'active'.  Those credentials are the
        input parameters for isAccessAllowed from the Architecture for
        Describing SNMP Management Frameworks.

        Otherwise access rights are checked according to the security

        parameters resulting from the tag."                      i"The management context from which to obtain mteTriggerValueID.

        This may be wildcarded by leaving characters off the end.  For
        example use 'Repeater' to wildcard to 'Repeater1',
        'Repeater2', 'Repeater-999.87b', and so on.  To indicate such
        wildcarding is intended, mteTriggerContextNameWildcard must
        be 'true'.

        Each instance that fills the wildcard is independent of any
        additional instances, that is, wildcarded objects operate
        as if there were a separate table entry for each instance
        that fills the wildcard without having to actually predict
        all possible instances ahead of time.

        Operation of this feature assumes that the local system has a
        list of available contexts against which to apply the
        wildcard.  If the objects are being read from the local
        system, this is clearly the system's own list of contexts.
        For a remote system a local version of such a list is not
        defined by any current standard and may not be available, so
        this function MAY not be supported."                       �"Control for whether mteTriggerContextName is to be treated as
        fully-specified or wildcarded, with 'true' indicating wildcard."                      �"The number of seconds to wait between trigger samples.  To
        encourage consistency in sampling, the interval is measured
        from the beginning of one check to the beginning of the next
        and the timer is restarted immediately when it expires, not
        when the check completes.

        If the next sample begins before the previous one completed the
        system may either attempt to make the check or treat this as an
        error condition with the error 'sampleOverrun'.

        A frequency of 0 indicates instantaneous recognition of the
        condition.  This is not possible in many cases, but may
        be supported in cases where it makes sense and the system is
        able to do so.  This feature allows the MIB to be used in
        implementations where such interrupt-driven behavior is
        possible and is not likely to be supported for all MIB objects
        even then since such sampling generally has to be tightly
        integrated into low-level code.

        Systems that can support this SHOULD document those cases
        where it can be used.  In cases where it can not, setting this
        object to 0 should be disallowed."                       a"To go with mteTriggerObjects, the mteOwner of a group of
        objects from mteObjectsTable."                      X"The mteObjectsName of a group of objects from
        mteObjectsTable.  These objects are to be added to any
        Notification resulting from the firing of this trigger.

        A list of objects may also be added based on the event or on
        the value of mteTriggerTest.

        A length of 0 indicates no additional objects."                       |"A control to allow a trigger to be configured but not used.
        When the value is 'false' the trigger is not sampled."                       �"The control that allows creation and deletion of entries.
        Once made active an entry may not be modified except to
        delete it."                       N"A table of management event trigger information for delta
        sampling."                       �"Information about a single trigger's delta sampling.  Entries
        automatically exist in this this table for each mteTriggerEntry
        that has mteTriggerSampleType set to 'deltaValue'."                      e"The OBJECT IDENTIFIER (OID) of a TimeTicks, TimeStamp, or
        DateAndTime object that indicates a discontinuity in the value
        at mteTriggerValueID.

        The OID may be for a leaf object (e.g. sysUpTime.0) or may
        be wildcarded to match mteTriggerValueID.

        This object supports normal checking for a discontinuity in a
        counter.  Note that if this object does not point to sysUpTime
        discontinuity checking MUST still check sysUpTime for an overall
        discontinuity.

        If the object identified is not accessible the sample attempt
        is in error, with the error code as from an SNMP request.

        Bad object identifiers or a mismatch between truncating the
        identifier and the value of mteDeltaDiscontinuityIDWildcard
        result in operation as one would expect when providing the
        wrong identifier to a Get operation.  The Get will fail or get
        the wrong object.  If the value syntax of those objects is not
        usable, that results in an error that terminates the sample
        with a 'badType' error code."                      k"Control for whether mteTriggerDeltaDiscontinuityID is to be
        treated as fully-specified or wildcarded, with 'true'
        indicating wildcard. Note that the value of this object will
        be the same as that of the corresponding instance of
        mteTriggerValueIDWildcard when the corresponding

        mteTriggerSampleType is 'deltaValue'."                       �"The value 'timeTicks' indicates the
        mteTriggerDeltaDiscontinuityID of this row is of syntax
        TimeTicks.  The value 'timeStamp' indicates syntax TimeStamp.
        The value 'dateAndTime' indicates syntax DateAndTime."                       R"A table of management event trigger information for existence
        triggers."                       �"Information about a single existence trigger.  Entries
        automatically exist in this this table for each mteTriggerEntry
        that has 'existence' set in mteTriggerTest."                      @"The type of existence test to perform.  The trigger fires
        when the object at mteTriggerValueID is seen to go from
        present to absent, from absent to present, or to have it's
        value changed, depending on which tests are selected:

        present(0) - when this test is selected, the trigger fires
        when the mteTriggerValueID object goes from absent to present.

        absent(1)  - when this test is selected, the trigger fires
        when the mteTriggerValueID object goes from present to absent.
        changed(2) - when this test is selected, the trigger fires
        the mteTriggerValueID object value changes.

        Once the trigger has fired for either presence or absence it
        will not fire again for that state until the object has been
        to the other state. "                       �"Control for whether an event may be triggered when this entry
        is first set to 'active' and the test specified by
        mteTriggerExistenceTest is true.  Setting an option causes
        that trigger to fire when its test is true."                       j"To go with mteTriggerExistenceObjects, the mteOwner of a
        group of objects from mteObjectsTable."                      �"The mteObjectsName of a group of objects from
        mteObjectsTable.  These objects are to be added to any
        Notification resulting from the firing of this trigger for
        this test.

        A list of objects may also be added based on the overall
        trigger, the event or other settings in mteTriggerTest.

        A length of 0 indicates no additional objects."                       f"To go with mteTriggerExistenceEvent, the mteOwner of an event
        entry from the mteEventTable."                       �"The mteEventName of the event to invoke when mteTriggerType is
        'existence' and this trigger fires.  A length of 0 indicates no
        event."                       P"A table of management event trigger information for boolean
        triggers."                       �"Information about a single boolean trigger.  Entries
        automatically exist in this this table for each mteTriggerEntry
        that has 'boolean' set in mteTriggerTest."                      F"The type of boolean comparison to perform.

        The value at mteTriggerValueID is compared to
        mteTriggerBooleanValue, so for example if
        mteTriggerBooleanComparison is 'less' the result would be true
        if the value at mteTriggerValueID is less than the value of
        mteTriggerBooleanValue."                       L"The value to use for the test specified by
        mteTriggerBooleanTest."                      D"Control for whether an event may be triggered when this entry
        is first set to 'active' or a new instance of the object at
        mteTriggerValueID is found and the test specified by
        mteTriggerBooleanComparison is true.  In that case an event is
        triggered if mteTriggerBooleanStartup is 'true'."                       h"To go with mteTriggerBooleanObjects, the mteOwner of a group
        of objects from mteObjectsTable."                      �"The mteObjectsName of a group of objects from
        mteObjectsTable.  These objects are to be added to any
        Notification resulting from the firing of this trigger for
        this test.

        A list of objects may also be added based on the overall
        trigger, the event or other settings in mteTriggerTest.

        A length of 0 indicates no additional objects."                       `"To go with mteTriggerBooleanEvent, the mteOwner of an event
        entry from mteEventTable."                       �"The mteEventName of the event to invoke when mteTriggerType is
        'boolean' and this trigger fires.  A length of 0 indicates no
        event."                       R"A table of management event trigger information for threshold
        triggers."                       �"Information about a single threshold trigger.  Entries
        automatically exist in this table for each mteTriggerEntry
        that has 'threshold' set in mteTriggerTest."                      �"The event that may be triggered when this entry is first
        set to 'active' and a new instance of the object at
        mteTriggerValueID is found.  If the first sample after this
        instance becomes active is greater than or equal to
        mteTriggerThresholdRising and mteTriggerThresholdStartup is
        equal to 'rising' or 'risingOrFalling', then one
        mteTriggerThresholdRisingEvent is triggered for that instance.
        If the first sample after this entry becomes active is less
        than or equal to mteTriggerThresholdFalling and
        mteTriggerThresholdStartup is equal to 'falling' or
        'risingOrFalling', then one mteTriggerThresholdRisingEvent is
        triggered for that instance."                      �"A threshold value to check against if mteTriggerType is
        'threshold'.

        When the current sampled value is greater than or equal to
        this threshold, and the value at the last sampling interval
        was less than this threshold, one
        mteTriggerThresholdRisingEvent is triggered.  That event is
        also triggered if the first sample after this entry becomes
        active is greater than or equal to this threshold and
        mteTriggerThresholdStartup is equal to 'rising' or
        'risingOrFalling'.

        After a rising event is generated, another such event is not
        triggered until the sampled value falls below this threshold
        and reaches mteTriggerThresholdFalling."                      �"A threshold value to check against if mteTriggerType is
        'threshold'.

        When the current sampled value is less than or equal to this
        threshold, and the value at the last sampling interval was
        greater than this threshold, one
        mteTriggerThresholdFallingEvent is triggered.  That event is
        also triggered if the first sample after this entry becomes
        active is less than or equal to this threshold and
        mteTriggerThresholdStartup is equal to 'falling' or
        'risingOrFalling'.

        After a falling event is generated, another such event is not
        triggered until the sampled value rises above this threshold
        and reaches mteTriggerThresholdRising."                      �"A threshold value to check against if mteTriggerType is
        'threshold'.

        When the delta value (difference) between the current sampled
        value (value(n)) and the previous sampled value (value(n-1))
        is greater than or equal to this threshold,
        and the delta value calculated at the last sampling interval
        (i.e. value(n-1) - value(n-2)) was less than this threshold,
        one mteTriggerThresholdDeltaRisingEvent is triggered. That event
        is also triggered if the first delta value calculated after this
        entry becomes active, i.e. value(2) - value(1), where value(1)
        is the first sample taken of that instance, is greater than or
        equal to this threshold.

        After a rising event is generated, another such event is not
        triggered until the delta value falls below this threshold and
        reaches mteTriggerThresholdDeltaFalling."                      �"A threshold value to check against if mteTriggerType is
        'threshold'.

        When the delta value (difference) between the current sampled
        value (value(n)) and the previous sampled value (value(n-1))
        is less than or equal to this threshold,
        and the delta value calculated at the last sampling interval
        (i.e. value(n-1) - value(n-2)) was greater than this threshold,
        one mteTriggerThresholdDeltaFallingEvent is triggered. That event
        is also triggered if the first delta value calculated after this
        entry becomes active, i.e. value(2) - value(1), where value(1)
        is the first sample taken of that instance, is less than or
        equal to this threshold.

        After a falling event is generated, another such event is not
        triggered until the delta value falls below this threshold and
        reaches mteTriggerThresholdDeltaRising."                       j"To go with mteTriggerThresholdObjects, the mteOwner of a group
        of objects from mteObjectsTable."                      �"The mteObjectsName of a group of objects from
        mteObjectsTable.  These objects are to be added to any
        Notification resulting from the firing of this trigger for
        this test.

        A list of objects may also be added based on the overall

        trigger, the event or other settings in mteTriggerTest.

        A length of 0 indicates no additional objects."                       h"To go with mteTriggerThresholdRisingEvent, the mteOwner of an
        event entry from mteEventTable."                       �"The mteEventName of the event to invoke when mteTriggerType is
        'threshold' and this trigger fires based on
        mteTriggerThresholdRising.  A length of 0 indicates no event."                       i"To go with mteTriggerThresholdFallingEvent, the mteOwner of an
        event entry from mteEventTable."                       �"The mteEventName of the event to invoke when mteTriggerType is
        'threshold' and this trigger fires based on
        mteTriggerThresholdFalling.  A length of 0 indicates no event."                       m"To go with mteTriggerThresholdDeltaRisingEvent, the mteOwner
        of an event entry from mteEventTable."                       �"The mteEventName of the event to invoke when mteTriggerType is
        'threshold' and this trigger fires based on
        mteTriggerThresholdDeltaRising. A length of 0 indicates
        no event."                       n"To go with mteTriggerThresholdDeltaFallingEvent, the mteOwner
        of an event entry from mteEventTable."                       �"The mteEventName of the event to invoke when mteTriggerType is
        'threshold' and this trigger fires based on
        mteTriggerThresholdDeltaFalling.  A length of 0 indicates
        no event."                           �"A table of objects that can be added to notifications based
        on the trigger, trigger test, or event, as pointed to by
        entries in those tables."                      4"A group of objects.  Applications create and delete entries
        using mteObjectsEntryStatus.

        When adding objects to a notification they are added in the
        lexical order of their index in this table.  Those associated
        with a trigger come first, then trigger test, then event."                       S"A locally-unique, administratively assigned name for a group
        of objects."                      i"An arbitrary integer for the purpose of identifying
        individual objects within a mteObjectsName group.

        Objects within a group are placed in the notification in the
        numerical order of this index.

        Groups are placed in the notification in the order of the
        selections for overall trigger, trigger test, and event.
        Within trigger test they are in the same order as the
        numerical values of the bits defined for mteTriggerTest.

        Bad object identifiers or a mismatch between truncating the
        identifier and the value of mteDeltaDiscontinuityIDWildcard
        result in operation as one would expect when providing the
        wrong identifier to a Get operation.  The Get will fail or get
        the wrong object.  If the object is not available it is omitted
        from the notification."                      /"The object identifier of a MIB object to add to a
        Notification that results from the firing of a trigger.

        This may be wildcarded by truncating all or part of the
        instance portion, in which case the instance portion of the
        OID for obtaining this object will be the same as that used
        in obtaining the mteTriggerValueID that fired.  If such
        wildcarding is applied, mteObjectsIDWildcard must be
        'true' and if not it must be 'false'.

        Each instance that fills the wildcard is independent of any
        additional instances, that is, wildcarded objects operate
        as if there were a separate table entry for each instance
        that fills the wildcard without having to actually predict
        all possible instances ahead of time."                       "Control for whether mteObjectsID is to be treated as
        fully-specified or wildcarded, with 'true' indicating wildcard."                       �"The control that allows creation and deletion of entries.
        Once made active an entry MAY not be modified except to
        delete it."                           �"The number of times an attempt to invoke an event
        has failed.  This counts individually for each
        attempt in a group of targets or each attempt for a
        wildcarded trigger object."                       1"A table of management event action information."                       o"Information about a single event.  Applications create and
        delete entries using mteEventEntryStatus."                       J"A locally-unique, administratively assigned name for the
        event."                       0"A description of the event's function and use."                       "The actions to perform when this event occurs.

        For 'notification', Traps and/or Informs are sent according
        to the configuration in the SNMP Notification MIB.

        For 'set', an SNMP Set operation is performed according to
        control values in this entry."                     -- No bits set.
 �"A control to allow an event to be configured but not used.
        When the value is 'false' the event does not execute even if

        triggered."                       �"The control that allows creation and deletion of entries.
        Once made active an entry MAY not be modified except to
        delete it."                       g"A table of information about notifications to be sent as a
        consequence of management events."                       �"Information about a single event's notification.  Entries
        automatically exist in this this table for each mteEventEntry
        that has 'notification' set in mteEventActions."                       �"The object identifier from the NOTIFICATION-TYPE for the
        notification to use if metEventActions has 'notification' set."                       k"To go with mteEventNotificationObjects, the mteOwner of a
        group of objects from mteObjectsTable."                      h"The mteObjectsName of a group of objects from
        mteObjectsTable if mteEventActions has 'notification' set.
        These objects are to be added to any Notification generated by
        this event.

        Objects may also be added based on the trigger that stimulated
        the event.

        A length of 0 indicates no additional objects."                       1"A table of management event action information."                       �"Information about a single event's set option.  Entries
        automatically exist in this this table for each mteEventEntry
        that has 'set' set in mteEventActions."                      �"The object identifier from the MIB object to set if
        mteEventActions has 'set' set.

        This object identifier may be wildcarded by leaving
        sub-identifiers off the end, in which case
        nteEventSetObjectWildCard must be 'true'.

        If mteEventSetObject is wildcarded the instance used to set the
        object to which it points is the same as the instance from the
        value of mteTriggerValueID that triggered the event.

        Each instance that fills the wildcard is independent of any
        additional instances, that is, wildcarded objects operate
        as if there were a separate table entry for each instance
        that fills the wildcard without having to actually predict
        all possible instances ahead of time.

        Bad object identifiers or a mismatch between truncating the
        identifier and the value of mteSetObjectWildcard
        result in operation as one would expect when providing the
        wrong identifier to a Set operation.  The Set will fail or set
        the wrong object.  If the value syntax of the destination
        object is not correct, the Set fails with the normal SNMP
        error code."                       �"Control over whether mteEventSetObject is to be treated as
        fully-specified or wildcarded, with 'true' indicating wildcard
        if mteEventActions has 'set' set."                       f"The value to which to set the object at mteEventSetObject
        if mteEventActions has 'set' set."                       "The tag for the target(s) at which to set the object at
        mteEventSetObject to mteEventSetValue if mteEventActions
        has 'set' set.

        Systems limited to self management MAY reject a non-zero
        length for the value of this object.

        A length of 0 indicates the local system.  In this case,
        access to the objects indicated by mteEventSetObject is under
        the security credentials of the requester that set
        mteTriggerEntryStatus to 'active'.  Those credentials are the
        input parameters for isAccessAllowed from the Architecture for
        Describing SNMP Management Frameworks.

        Otherwise access rights are checked according to the security
        parameters resulting from the tag."                      �"The management context in which to set mteEventObjectID.
        if mteEventActions has 'set' set.

        This may be wildcarded by leaving characters off the end.  To
        indicate such wildcarding mteEventSetContextNameWildcard must
        be 'true'.

        If this context name is wildcarded the value used to complete
        the wildcarding of mteTriggerContextName will be appended."                       �"Control for whether mteEventSetContextName is to be treated as
        fully-specified or wildcarded, with 'true' indicating wildcard
        if mteEventActions has 'set' set."                               �"Notification that the trigger indicated by the object
        instances has fired, for triggers with mteTriggerType
        'boolean' or 'existence'."                 g"Notification that the rising threshold was met for triggers
        with mteTriggerType 'threshold'."                 h"Notification that the falling threshold was met for triggers
        with mteTriggerType 'threshold'."                x"Notification that an attempt to check a trigger has failed.

        The network manager must enable this notification only with
        a certain fear and trembling, as it can easily crowd out more
        important information.  It should be used only to help diagnose
        a problem that has appeared in the error counters and can not
        be found otherwise."                �"Notification that an attempt to do a set in response to an
        event has failed.

        The network manager must enable this notification only with
        a certain fear and trembling, as it can easily crowd out more
        important information.  It should be used only to help diagnose
        a problem that has appeared in the error counters and can not
        be found otherwise."                     3"The name of the trigger causing the notification."                       P"The SNMP Target MIB's snmpTargetAddrName related to the
        notification."                       �"The context name related to the notification.  This MUST be as
        fully-qualified as possible, including filling in wildcard
        information determined in processing."                      o"The object identifier of the destination object related to the
        notification.  This MUST be as fully-qualified as possible,
        including filling in wildcard information determined in
        processing.

        For a trigger-related notification this is from
        mteTriggerValueID.

        For a set failure this is from mteEventSetObject."                       M"The value of the object at mteTriggerValueID when a
        trigger fired."                       ~"The reason for the failure of an attempt to check for a
        trigger condition or set an object in response to an event."                               W"The compliance statement for entities which implement
                the Event MIB."   �"Write access is not required, thus limiting
                        monitoring to the local system or pre-configured
                        remote systems." �"Write access is not required, thus limiting
                        setting to the local system or pre-configured
                        remote systems." o"Write access is not required, thus allowing
                        the system not to implement wildcarding." o"Write access is not required, thus allowing
                        the system not to implement wildcarding." o"Write access is not required, thus allowing
                        the system not to implement wildcarding." o"Write access is not required, thus allowing
                        the system not to implement wildcarding."                 ,"Event resource status and control objects."                 "Event triggers."                 "Supplemental objects."                 	"Events."                 "Notification objects."                 "Notifications."                        