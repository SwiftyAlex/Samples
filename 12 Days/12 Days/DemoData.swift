//
//  DemoData.swift
//  12 Days
//
//  Created by Alex Logan on 26/12/2022.
//

import Foundation

enum DemoData {
    enum Strings: String, CaseIterable {
        case short, long

        var rawValue: String {
            switch self {
            case .long:
                return """
                I have this thing where I get older but just never wiser
                Midnights become my afternoons
                When my depression works the graveyard shift
                All of the people I've ghosted stand there in the room

                I should not be left to my own devices
                They come with prices and vices
                I end up in crisis (tale as old as time)
                I wake up screaming from dreaming
                One day I'll watch as you're leaving
                'Cause you got tired of my scheming
                (For the last time)

                It's me, hi, I'm the problem, it's me
                At tea time, everybody agrees
                I'll stare directly at the sun but never in the mirror
                It must be exhausting, always rooting for the anti-hero

                Sometimes I feel like everybody is a sexy baby
                And I'm a monster on the hill
                Too big to hang out, slowly lurching toward your favorite city
                Pierced through the heart, but never killed

                Did you hear my covert narcissism I disguise as altruism
                Like some kind of congressman? (Tale as old as time)
                I wake up screaming from dreaming
                One day I'll watch as you're leaving
                And life will lose all its meaning
                (For the last time)

                It's me, hi, I'm the problem, it's me (I'm the problem, it's me)
                At tea time, everybody agrees
                I'll stare directly at the sun but never in the mirror
                It must be exhausting, always rooting for the anti-hero

                I have this dream my daughter in-law kills me for the money
                She thinks I left them in the will
                The family gathers 'round and reads it and then someone screams out
                "She's laughing up at us from hell"

                It's me, hi, I'm the problem, it's me
                It's me, hi, I'm the problem, it's me
                It's me, hi, everybody agrees, everybody agrees

                It's me, hi (hi), I'm the problem, it's me (I'm the problem, it's me)
                At tea (tea) time (time), everybody agrees (everybody agrees)
                I'll stare directly at the sun but never in the mirror
                It must be exhausting, always rooting for the anti-hero
                """
            case .short:
                return """
                It's me, hi, I'm the problem, it's me
                At tea time, everybody agrees
                """
            }
        }
    }
}
