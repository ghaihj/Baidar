<?php

namespace App\Filament\Resources\PlantRegionProfiles;

use App\Filament\Resources\PlantRegionProfiles\Pages\CreatePlantRegionProfile;
use App\Filament\Resources\PlantRegionProfiles\Pages\EditPlantRegionProfile;
use App\Filament\Resources\PlantRegionProfiles\Pages\ListPlantRegionProfiles;
use App\Filament\Resources\PlantRegionProfiles\Schemas\PlantRegionProfileForm;
use App\Filament\Resources\PlantRegionProfiles\Tables\PlantRegionProfilesTable;
use App\Models\Plant;
use App\Models\PlantRegionProfile;
use App\Models\Region;
use BackedEnum;
use Filament\Actions\BulkActionGroup;
use Filament\Actions\DeleteAction;
use Filament\Actions\DeleteBulkAction;
use Filament\Actions\EditAction;
use Filament\Forms\Components\Select;
use Filament\Forms\Components\Textarea;
use Filament\Forms\Components\TextInput;
use Filament\Resources\Resource;
use Filament\Schemas\Components\Section;
use Filament\Schemas\Schema;
use Filament\Support\Icons\Heroicon;
use Filament\Tables\Columns\TextColumn;
use Filament\Tables\Filters\SelectFilter;
use Filament\Tables\Table;

class PlantRegionProfileResource extends Resource
{
    protected static ?string $model = PlantRegionProfile::class;

    protected static string|BackedEnum|null $navigationIcon = Heroicon::OutlinedRectangleStack;

    protected static ?string $recordTitleAttribute = 'PlantRegionProfile';

    public static function form(Schema $schema): Schema
    {
        return $schema
            ->components([
                // --- القسم 1: الربط الأساسي ---
                Section::make('الربط الأساسي')
                    ->schema([
                        Select::make('plant_id')
                            ->label('النبات')
                            ->options(Plant::pluck('name_ar', 'id'))
                            ->searchable()
                            ->required(),

                        Select::make('region_id')
                            ->label('المنطقة')
                            ->options(Region::pluck('name_ar', 'id'))
                            ->searchable()
                            ->required(),
                    ])->columns(2),

                // --- القسم 2: التربة ---
                Section::make('التربة')
                    ->schema([
                        TextInput::make('soil_type')
                            ->label('نوع التربة')
                            ->maxLength(200),

                        TextInput::make('soil_ph_min')
                            ->label('أدنى pH')
                            ->numeric()
                            ->step(0.1)
                            ->minValue(0)
                            ->maxValue(14),

                        TextInput::make('soil_ph_max')
                            ->label('أقصى pH')
                            ->numeric()
                            ->step(0.1)
                            ->minValue(0)
                            ->maxValue(14),
                    ])->columns(3),

                // --- القسم 3: المياه ---
                Section::make('المياه')
                    ->schema([
                        TextInput::make('water_amount_mm')
                            ->label('كمية الري (مم/أسبوع)')
                            ->numeric(),

                        TextInput::make('watering_frequency')
                            ->label('عدد مرات الري')
                            ->placeholder('مثال: مرتين أسبوعياً')
                            ->maxLength(50),
                    ])->columns(2),

                // --- القسم 4: الحرارة والرطوبة ---
                Section::make('الحرارة والرطوبة')
                    ->schema([
                        TextInput::make('temp_min_c')
                            ->label('أدنى حرارة (°م)')
                            ->numeric()
                            ->step(0.1),

                        TextInput::make('temp_max_c')
                            ->label('أقصى حرارة (°م)')
                            ->numeric()
                            ->step(0.1),

                        TextInput::make('humidity_min')
                            ->label('أدنى رطوبة (%)')
                            ->numeric()
                            ->minValue(0)
                            ->maxValue(100),

                        TextInput::make('humidity_max')
                            ->label('أقصى رطوبة (%)')
                            ->numeric()
                            ->minValue(0)
                            ->maxValue(100),
                    ])->columns(4),

                // --- القسم 5: الشمس ---
                Section::make('الشمس')
                    ->schema([
                        TextInput::make('sun_hours_min')
                            ->label('أدنى ساعات شمس')
                            ->numeric(),

                        TextInput::make('sun_hours_max')
                            ->label('أقصى ساعات شمس')
                            ->numeric(),
                    ])->columns(2),

                // --- القسم 6: التقويم الزراعي ---
                Section::make('التقويم الزراعي')
                    ->schema([
                        Select::make('planting_start_month')
                            ->label('شهر بداية الزراعة')
                            ->options(self::months()),

                        Select::make('planting_end_month')
                            ->label('شهر نهاية الزراعة')
                            ->options(self::months()),

                        Select::make('harvest_start_month')
                            ->label('شهر بداية الحصاد')
                            ->options(self::months()),

                        Select::make('harvest_end_month')
                            ->label('شهر نهاية الحصاد')
                            ->options(self::months()),

                        TextInput::make('spacing_cm')
                            ->label('المسافة بين النباتات (سم)')
                            ->numeric(),
                    ])->columns(3),

                // --- القسم 7: نصوص حرة ---
                Section::make('إرشادات إضافية')
                    ->schema([
                        Textarea::make('fertilization_notes')
                            ->label('إرشادات التسميد')
                            ->rows(3)
                            ->columnSpanFull(),

                        Textarea::make('common_diseases')
                            ->label('الأمراض والآفات الشائعة')
                            ->rows(3)
                            ->columnSpanFull(),
                    ]),
            ]);
    }

    public static function table(Table $table): Table
    {
        return $table
            ->columns([
                TextColumn::make('plant.name_ar')
                    ->label('النبات')
                    ->searchable()
                    ->sortable(),

                TextColumn::make('region.name_ar')
                    ->label('المنطقة')
                    ->searchable()
                    ->sortable(),

                TextColumn::make('soil_type')
                    ->label('التربة')
                    ->limit(30),

                TextColumn::make('watering_frequency')
                    ->label('الري'),

                TextColumn::make('planting_start_month')
                    ->label('زراعة (من)')
                    ->formatStateUsing(fn($state) => self::monthName($state)),

                TextColumn::make('planting_end_month')
                    ->label('زراعة (إلى)')
                    ->formatStateUsing(fn($state) => self::monthName($state)),

                TextColumn::make('updated_at')
                    ->label('آخر تحديث')
                    ->dateTime('Y-m-d'),
            ])
            ->filters([
                SelectFilter::make('region_id')
                    ->label('المنطقة')
                    ->options(Region::pluck('name_ar', 'id')),

                SelectFilter::make('plant_id')
                    ->label('النبات')
                    ->options(Plant::pluck('name_ar', 'id')),
            ])
            ->actions([
                EditAction::make(),
                DeleteAction::make(),
            ])
            ->bulkActions([
                BulkActionGroup::make([
                    DeleteBulkAction::make(),
                ]),
            ]);
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

    // --- دوال مساعدة للأشهر ---
    protected static function months(): array
    {
        return [
            1 => 'كانون الثاني (1)',
            2 => 'شباط (2)',
            3 => 'آذار (3)',
            4 => 'نيسان (4)',
            5 => 'أيار (5)',
            6 => 'حزيران (6)',
            7 => 'تموز (7)',
            8 => 'آب (8)',
            9 => 'أيلول (9)',
            10 => 'تشرين الأول (10)',
            11 => 'تشرين الثاني (11)',
            12 => 'كانون الأول (12)',
        ];
    }

    protected static function monthName(?int $month): string
    {
        if (!$month) return '-';
        return self::months()[$month] ?? '-';
    }
}
