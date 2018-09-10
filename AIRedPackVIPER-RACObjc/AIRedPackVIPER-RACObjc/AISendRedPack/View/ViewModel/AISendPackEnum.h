//
//  AISendPackEnum.h
//  Tomato
//
//  Created by aizexin on 2018/9/4.
//

#ifndef AISendPackEnum_h
#define AISendPackEnum_h

typedef enum : NSUInteger {
    AISendPackType_None,
    AISendPackType_Single,
    AISendPackType_Group_Normal,
    AISendPackType_Group_Random
} AISendPackType;
typedef enum : NSUInteger {
    AISendPackCellType_redPack,
    AISendPackCellType_greeting,
} AISendPackCellType;
#endif /* AISendPackEnum_h */
