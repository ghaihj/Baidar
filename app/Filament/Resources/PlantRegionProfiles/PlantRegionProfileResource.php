<?php

namespace App\Filament\Resources\PlantRegionProfiles;

use App\Filament\Resources\PlantRegionProfiles\Pages\CreatePlantRegionProfile;
use App\Filament\Resources\PlantRegionProfiles\Pages\EditPlantRegionProfile;
use App\Filament\Resources\PlantRegionProfiles\Pages\ListPlantRegionProfiles;
use App\Filament\Resources\PlantRegionProfiles\Schemas\PlantRegionProfileForm;
use App\Filament\Resources\PlantRegionProfiles\Tables\PlantRegionProfilesTable;
use App\Models\PlantRegionProfile;
use BackedEnum;
use Filament\Resources\Resource;
use Filament\Schemas\Schema;
use Filament\Support\Icons\Heroicon;
use Filament\Tables\Table;

class PlantRegionProfileResource extends Resource
{
    protected static ?string $model = PlantRegionProfile::class;

    protected static string|BackedEnum|null $navigationIcon = Heroicon::OutlinedRectangleStack;

    protected static ?string $recordTitleAttribute = 'PlantRegionProfile';

    public static function form(Schema $schema): Schema
    {
        return PlantRegionProfileForm::configure($schema);
    }

    public static function table(Table $table): Table
    {
        return PlantRegionProfilesTable::configure($table);
    }

    public static function getRelations(): array
    {
        return [
            //
        ];
    }

    public static function getPages(): array
    {
        return [
            'index' => ListPlantRegionProfiles::route('/'),
            'create' => CreatePlantRegionProfile::route('/create'),
            'edit' => EditPlantRegionProfile::route('/{record}/edit'),
        ];
    }
}
