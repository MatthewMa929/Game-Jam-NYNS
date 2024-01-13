/////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Audiokinetic Wwise generated include file. Do not edit.
//
/////////////////////////////////////////////////////////////////////////////////////////////////////

#ifndef __WWISE_IDS_H__
#define __WWISE_IDS_H__

#include <AK/SoundEngine/Common/AkTypes.h>

namespace AK
{
    namespace EVENTS
    {
        static const AkUniqueID CRYSTAL_BREAK = 756738409U;
        static const AkUniqueID DRILL_MINING = 737866587U;
        static const AkUniqueID LOWOXYGEN = 534520757U;
        static const AkUniqueID OXYGENREFILL = 30680937U;
        static const AkUniqueID PLAY_CAVE_OST = 1479112770U;
        static const AkUniqueID PLAY_COLONY_OST = 3238935255U;
        static const AkUniqueID STOP_CAVE_OST = 2296272484U;
        static const AkUniqueID STOP_COLONY_OST = 2414364521U;
        static const AkUniqueID STOP_DRILL_MINING = 2118051910U;
        static const AkUniqueID UICLICK = 3164408517U;
        static const AkUniqueID WORMTUNNEL = 4256651350U;
    } // namespace EVENTS

    namespace STATES
    {
        namespace LOW_OXYGEN
        {
            static const AkUniqueID GROUP = 1860436912U;

            namespace STATE
            {
                static const AkUniqueID NONE = 748895195U;
            } // namespace STATE
        } // namespace LOW_OXYGEN

        namespace WORM_IN_RANGE
        {
            static const AkUniqueID GROUP = 1865816856U;

            namespace STATE
            {
                static const AkUniqueID FALSE = 2452206122U;
                static const AkUniqueID NONE = 748895195U;
                static const AkUniqueID TRUE = 3053630529U;
            } // namespace STATE
        } // namespace WORM_IN_RANGE

    } // namespace STATES

    namespace GAME_PARAMETERS
    {
        static const AkUniqueID MUSIC_VOLUME = 1006694123U;
        static const AkUniqueID PLAYEROXYGEN = 2603805318U;
        static const AkUniqueID SFX_VOLUME = 1564184899U;
        static const AkUniqueID WORM_DISTANCE_PITCH = 3649139729U;
    } // namespace GAME_PARAMETERS

    namespace BANKS
    {
        static const AkUniqueID INIT = 1355168291U;
        static const AkUniqueID MAIN = 3161908922U;
    } // namespace BANKS

    namespace BUSSES
    {
        static const AkUniqueID ENVIRONMENTAL = 1973600711U;
        static const AkUniqueID MASTER_AUDIO_BUS = 3803692087U;
        static const AkUniqueID MUSIC = 3991942870U;
        static const AkUniqueID SOUND_EFFECTS = 978636652U;
    } // namespace BUSSES

    namespace AUDIO_DEVICES
    {
        static const AkUniqueID NO_OUTPUT = 2317455096U;
        static const AkUniqueID SYSTEM = 3859886410U;
    } // namespace AUDIO_DEVICES

}// namespace AK

#endif // __WWISE_IDS_H__
